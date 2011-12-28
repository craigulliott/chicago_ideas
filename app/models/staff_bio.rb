class StaffBio < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset

  validates :sort, :presence => true
  validates :name, :presence => true
  validates :title, :presence => true
  validates_uniqueness_of :sort
  
  # when this model is created, set the sort order to the last in the current set (unless it was already set)
  before_validation {|record|
    return true if record.sort.present?
    record.sort = StaffBio.maximum(:sort).to_i + 1
  }
  
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
  has_attached_file :portrait,
    :storage => :fog,
    :fog_credentials => {
      :aws_access_key_id => AWS_ACCESS_KEY_ID,
      :aws_secret_access_key => AWS_SECRET_ACCESS_KEY,
      provider: 'AWS',
      region: 'us-east-1'
    },
    :fog_public => true,
    :fog_directory => "#{S3_NAMESPACE}-craigs-admin-staff_bio-portraits",
    :path => ":id.:extension"

  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :title => title,
      :about => about,
      :portrait => portrait,
      :sort => sort,
    }
  end

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :search, :as => :string, :fields => [:name], :wildcard => :both },
        { :name => :created_at, :as => :datetimerange }, 
      ]
    end
  end
  
end
