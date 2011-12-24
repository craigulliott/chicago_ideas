class Api::ApiController < ApplicationController
  
  # for the documentation
  layout 'api'
  
  before_filter :log_api_activity!
  
  private 

    # tests for boolean, looks for certain human known flavours of "true"
    def api_boolean(value)
      return [true, "true", "t", "yes", "yep", "yea", "y", 1, "1"].include?(value.class == String ? value.downcase : value)
    end

    # params are not nested, when posed to the api.  So we strip these 'fake' prams out
    def api_params
      p = params.dup
      p.delete :controller
      p.delete :action
      p.delete :access_token
      p.delete :version
      return p
    end

    # output helpers 
    # --------------------------------------

      # a standard way to return models. if they have errors then we return the error message
      # this is a DRY approach to creating and updating and then returning JSON responses
      def json_model model, extra_params={}
        if model.errors.empty?
          render :json => model.api_attributes.deep_merge(extra_params)
        else
          json_error :model_error, model.errors.first.join(' ')
        end
      end

      # a standard way to return an array of models
      # arrays of models are passed back in a data object, this is so we can add things we may need in the future such as pagination
      def json_models models, access_level = nil
        # newer versions of the API clients expect results be be sent keyed with data (so we can add pagination later)
        if params.key?(:version) && params[:version] != '1.1.0' && params[:version] != '1.0.0' && params[:version] != '1.1.1'
          render :json => {
            :data => models.collect{|model| access_level.nil? ? model.api_attributes : model.api_attributes(access_level)} 
          }
        else
          render :json => models.collect{|model| access_level.nil? ? model.api_attributes : model.api_attributes(access_level)} 
        end
      end

      # helper for success messages (for actions like delete which dont return models)
      def json_success message
        render :json => {
          :success => true,
          :message => message
        }
      end

      # helper for returning failure messages in a common format
      def json_error code, message=nil, metadata={}
        render :json => {
          :error => metadata.merge({
            :message => message || t("api.errors.#{code}"),
            :code => code
          })
        }
      end
    
      # called from a before filter, this method will log all api activity
      # non scaler types are stripped out of the params hash before saving incase they are file attachments
      def log_api_activity!

        # clone in way which strips out attachments
        params_to_log = collect_hash_contents(params)

        params_to_log.delete('controller') 
        params_to_log.delete('action') 

        # we have some public API endpoints, so client_id can be null
        client_id = current_client.present? ? current_client.id : nil
        log_entry = ApiLogEntry.create!(:action => params[:controller]+'.'+params[:action], :params => params_to_log, :host => request.env["REMOTE_ADDR"] );

      end

end