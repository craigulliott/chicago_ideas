class Note < ActiveRecord::Base
  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  belongs_to :author, :class_name => 'User'

  validates :body, :presence => true
  belongs_to :asset, :polymorphic => true
  
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
  # note can have attachments
  has_attached_file :attachment,
    :fog_public => false,
    :fog_directory => "#{S3_NAMESPACE}-chicago-ideas-note-attachments",
    :path => ":id.:extension"


  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    [
      { :name => :search, :as => :string, :fields => [:body], :wildcard => :both },
      { :name => :created_at, :as => :datetimerange }, 
      { :name => :author_id, :label => 'Author', :as => :select, :collection => User.admin.all.collect {|p| [ p.name, p.id ] } },
    ]
  end
  
end
