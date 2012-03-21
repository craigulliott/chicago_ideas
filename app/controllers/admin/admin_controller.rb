# common admin area functionality made availiable to all admin controllers
class Admin::AdminController < ApplicationController
  
  # include all helpers, all the time
  helper :all 
  
  protect_from_forgery
  
  layout 'admin'
  
  before_filter :authenticate_user!
  before_filter :require_admin!
  before_filter :log_user_activity!

  # ADMIN ROOT
  # ---------------------------------------------------------------------------------------------------------
  def index
  end


  # Dynamic REST callback helpers
  # 
  # you can override these methods if you want to do some simple logic in your child controllers
  # these are useful if you dont want to override the standrad CRUD (REST) methods
  # ----------------------------------------------------------------------------------------------------
  
  def default_model
    {}
  end

  def before_destruction(model)
    # default allow delete
    return true
  end

  def succeeding_create(model)
  end
  def pre_create(model)
    return model
  end

  def succeeding_update(model)
  end
  def pre_update(model)
    return model
  end
  
  
  # create a note when most changes occur on data, and we log by whom it was changed we use
  # a method here because it will sometimes need to be overridden by the specific controllers
  # when the note needs to be associated with a different (usually parent) object
  # ----------------------------------------------------------------------------------------------------
  
  def model_note(model, body)
    model.notes.create(:author => current_user, :body => body)
  end


  # dynamic version of our standard 7 REST methods new / edit / index / show / create / update / delete
  # ----------------------------------------------------------------------------------------------------
  
  def new
    # if there is a model in the params, then we know this is a nested model... so set the foreign/parent id
    @parent = parent_model
    @model = new_model(default_model)
    render_json_response :ok, :html => render_to_string('admin/shared/form.html.haml', :layout => false)
  end
  
  def edit
    @model = fetch_model
    render_json_response :ok, :html => render_to_string('admin/shared/form.html.haml', :layout => false)
  end

  def create
    
    @parent = parent_model
    @model = new_model(params[model_name])
    @model = pre_create(@model)
    
    
    
    if @model.errors.empty? and @model.save
      # allows for some basic controler specific functionality without redefining the create method
      succeeding_create(@model)
      # add a note, so we can easily see who created this (unless of course this is a note)
      model_note(@model, "#{@model.class.name.titlecase} was successfully created.")
      render_json_model_created_response @model
    else
      # return the form, which will have error notices
      # if the form is for a model which accept file uploads, then we render the JSON response in an HTML container
      if @model.respond_to?('accepts_file_upload?') && @model.accepts_file_upload?
        render_json_response_in_iframe :error, :html => render_to_string('admin/shared/form.html.haml', :layout => false)
      else
        # otherwise send back JSON
        render_json_response :error, :html => render_to_string('admin/shared/form.html.haml', :layout => false)
      end
    end

  end
  
  def update
    @parent = parent_model
    @model = fetch_model

    @model = pre_update(@model)
    
    if @model.errors.empty? and @model.update_attributes(params[model_name])
      # allows for some basic controler specific functionality without redefining the create method
      succeeding_update(@model)
      # add a note, so we can easily see who updated this (unless of course this is a note)
      model_note(@model, "#{@model.class.name.titlecase} was successfully updated.")
      render_json_model_updated_response @model
    else
      # return the form, which will have error notices
      # if the form is for a model which accept file uploads, then we render the JSON response in an HTML container
      if @model.respond_to?('accepts_file_upload?') && @model.accepts_file_upload?
        render_json_response_in_iframe :error, :html => render_to_string('admin/shared/form.html.haml', :layout => false)
      else
        # otherwise send back JSON
        render_json_response :error, :html => render_to_string('admin/shared/form.html.haml', :layout => false)
      end
    end

  end

  def destroy
    @model = fetch_model
    
    allow = before_destruction(@model)
    
    if allow
      @model.destroy
      render_json_response :ok, :notice => "#{@model.class.name.titlecase} was successfully deleted."
    else
      render_json_response :error, :notice => 'you can not delete this.'
    end
    
  end


  # common controller actions
  # ----------------------------------------------------------------------------------------------------
  
  # Sorting items by drag and drop
	def sort
	  @model = model_name.camelize.constantize
		order = params[:node]
		@model.sort(order) if order.present?
		render_json_response :ok, :notice => "Successfully sorted!"
	end
	
	
  # mark as deleted, without actually destroying the record
  def delete
    @model = fetch_model
    @model.update_attribute(:deleted_at, Time.now)

    message = "#{@model.class.name.titlecase} was successfully deleted."

    model_note(@model, message)
    render_json_response :ok, :notice => message
  end

  def undelete
    @model = fetch_model
    @model.update_attribute(:deleted_at, nil)
    
    message = "#{@model.class.name.titlecase} was successfully restored."

    model_note(@model, message)
    render_json_response :ok, :notice => message
  end

  # mark as flagged or unflagged
  def flag
    @model = fetch_model
    @model.update_attribute(:flagged_by_user_id, current_user.id)

    message = "#{@model.class.name.titlecase} was successfully flagged."

    model_note(@model, message)
    render_json_response :ok, :notice => message
  end

  def unflag
    @model = fetch_model
    @model.update_attribute(:flagged_by_user_id, nil)

    message = "#{@model.class.name.titlecase} was successfully unflagged."

    model_note(@model, message)
    render_json_response :ok, :notice => message
  end

  # mark as published or unpublished
  def publish
    @model = fetch_model
    @model.update_attribute(:published, true)

    message = "#{@model.class.name.titlecase} was successfully published."

    model_note(@model, message)
    render_json_response :ok, :notice => message
  end

  def unpublish
    @model = fetch_model
    @model.update_attribute(:published, false)

    message = "#{@model.class.name.titlecase} was successfully unpublished."
    
    model_note(@model, message)
    render_json_response :ok, :notice => message
  end




  private
    # convert a hash of artificial_attributes into a select statment, convinient transofrmation for our SearchSortPaginate atrificial_attributes paradigm
    def select_query select_hash
      select_hash.collect{|k,v| "(#{v}) as `#{k}`"}.join(', ')
    end
  
    # used from a before filter, this method will block and redirect the user if they dont have admin access
    def require_admin!
      unless current_user.admin
        redirect_to root_path, :notice => 'you must be an admin to access this area'
      end
    end
    
    # relaods a collection of models, from just their id, in a single query (preserving the collection order)
    # the primary use of this method is to SQL SELECT large sets of data with only the id field in the initial query
    # and then preforming mysql sorts, sorting in mysql with lots of columns is very slow and uses a lot of memory
    def batch_reload models, options={}

      # if there are none, the just return what was sent
      if models.count < 1
        return models
      end

      # TODO:: one day this logic can be re-written to be much faster
      models.each_index do |i|
        models[i].reload
      end
      
      return models
      
    end

    # called from a before_filter, this method will log all user activity
    # non scaler types are stripped out of the params hash before saving incase they are file attachments
    def log_user_activity!
    
      # clone in way which strips out attachments
      params_to_log = collect_hash_contents(params)

      params_to_log.delete('controller') 
      params_to_log.delete('action') 
      
      log_entry = LogEntry.create!( :user_id => current_user.id, :action => params[:controller]+'.'+params[:action], :params => params_to_log, :referrer => request.env["HTTP_REFERER"], :user_agent => request.env["HTTP_USER_AGENT"], :host => request.env["REMOTE_ADDR"] );
      
    end

    # JSON output helpers, defined here to DRY up the code
    # ----------------------------------------------------------------------------------------------------
    
    # when POSTing forms with file attachments, we cant use AJAX.  We post to an iframe and get the response out of the resulting page
    def render_json_response_in_iframe type, hash={}
      render 'shared/iframe_json_response.html.haml', :layout => false, :locals => {:json_result => json_response(type, hash)}
    end

    # DRY approach to returning models in JSON
    def json_model_response(new_model, message, action=nil)
      template_path = 'admin/'+new_model.class.name.underscore.pluralize.to_s+'/_'+new_model.class.name.underscore+'.html.haml'
      model_html = render_to_string( template_path, :layout => false, :locals => { new_model.class.name.underscore.to_sym => new_model } )
      response = {:notice => message, :html => model_html }
      model_data = { :type => new_model.class.name.underscore, :types => new_model.class.name.underscore.pluralize, :id => new_model.id }

      case action 
        when 'created'
          response[:created] = model_data
        when 'updated'
          response[:updated] = model_data
      end

      return response
    end

    # wrapper for json_model_response above, this renders out the result of REST creates and updates
    def render_json_model_response(new_model, message_suffix, action=nil, use_iframe=false)
      # the json we want to send back to the client
      model_response_json = json_model_response(new_model, message_suffix, action)
      # if we are posting to an iframe (to upload a file) then we need to return the JSON in an html page
      if use_iframe
        render_json_response_in_iframe :ok, model_response_json
      else
        render_json_response :ok, model_response_json
      end
    end

    # Create and Update wrappers for the render_json_model_response above which puts the result in an html document 
    # useful when POSTing forms with file attachments as we cant use AJAX. 
    def render_json_model_created_response(new_model)
      use_iframe = @model.respond_to?('accepts_file_upload?') && @model.accepts_file_upload?
      render_json_model_response(new_model, new_model.class.name.titlecase+' successfully created', 'created', use_iframe)    
    end
    def render_json_model_updated_response(updated_model)
      use_iframe = @model.respond_to?('accepts_file_upload?') && @model.accepts_file_upload?
      render_json_model_response(updated_model, updated_model.class.name.titlecase+' successfully updated', 'updated', use_iframe)    
    end

end