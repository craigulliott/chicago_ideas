class <%= model_class_name %> < ActiveRecord::Base

<% if has_deleted_at_attribute? -%>  
  # chainable arel method and a boolean helper to determine if models are deleted or not
  include DeleteByTime

<% end -%>
  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

<% attributes.each do |attribute| -%>
<% if attribute.name[-3,3] == '_id' -%>
  belongs_to :<%= attribute.name[0..-4] %>
<% end -%>
<% end -%>
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
<% if has_a_file_attribute? -%>  
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
<% end -%>
<% attributes.each do |attribute| -%>
<% if attribute.type == :file -%>
  has_attached_file :<%= attribute.name %>,
    :storage => :fog,
    :fog_credentials => {
      :aws_access_key_id => AWS_ACCESS_KEY_ID,
      :aws_secret_access_key => AWS_SECRET_ACCESS_KEY,
      provider: 'AWS',
      region: 'us-east-1'
    },
    :fog_public => true,
    :fog_directory => "<%= ENV['DATABASE_NAMESPACE'] %>-<%= singular_table_name %>-<%= attribute.name.pluralize %>",
    :path => ":id.:extension"

<% end -%>
<% end -%>  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
<% attributes.each do |attribute| -%>
<% next if attribute.name.to_sym == :deleted_at -%>
<% if attribute.name[-3,3] == '_id' -%>
      :<%= attribute.name[0..-4] %> => <%= attribute.name[0..-4] %>.api_attributes,
<% else -%>
      :<%= attribute.name %> => <%= attribute.name %>,
<% end -%>
<% end -%>
    }
  end

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
<% if has_name_attribute? -%>
        { :name => :search, :as => :string, :fields => [:name], :wildcard => :both },
<% end -%>
        { :name => :created_at, :as => :datetimerange }, 
      ]
    end
  end
  
end
