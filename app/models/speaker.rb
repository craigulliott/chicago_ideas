class Speaker < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :name, :presence => true
  validates_uniqueness_of :name
  
  validates :permalink, :presence => true
  validates_uniqueness_of :permalink

  # clean up/normalize the twitter handle
  before_validation {|record|
    # normalize the twitter name (some people enter @screenname and other just enter screenname - we strip the @)
    record.twitter_screen_name = record.twitter_screen_name[1..9999] if record.twitter_screen_name.present? && record.twitter_screen_name[0] == '@'
    
    # generate an availiable permalink
    permalink = name.underscore
    i = nil
    while Speaker.find_by_permalink("#{permalink}#{i}").count > 0
      i = (i||0)+1
    end
    record.permalink = permalink
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
    :fog_directory => "chicago-ideas-speaker-portraits",
    :path => ":id.:extension"

  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :title => title,
      :bio => bio,
      :twitter_screen_name => twitter_screen_name,
      :facebook_page => facebook_page_id,
      :portrait => portrait,
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
