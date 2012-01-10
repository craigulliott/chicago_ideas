class Event < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  BANNER_WIDTH = 1400
  BANNER_HEIGHT = 390

  belongs_to :partner
  belongs_to :day
  belongs_to :venue
  belongs_to :event_brand
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :name, :presence => true
  validates :day_id, :presence => true
  validates :venue_id, :presence => true
  validates :event_brand_id, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true
  validate :validate_banner_dimensions, :if => "banner.present?", :unless => "errors.any?"
  validate :validate_temporal_sanity, :unless => "errors.any?"
  
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
  # large format blessed photo for the website
  has_attached_file :banner,
    :storage => :fog,
    :fog_credentials => {
      :aws_access_key_id => AWS_ACCESS_KEY_ID,
      :aws_secret_access_key => AWS_SECRET_ACCESS_KEY,
      provider: 'AWS',
      region: 'us-east-1'
    },
    :fog_public => true,
    :fog_directory => "#{S3_NAMESPACE}-chicago-ideas-event-banners",
    :path => ":id.:extension"
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :description => description,
      :partner => partner.api_attributes,
      :day => day.api_attributes,
      :venue => venue.api_attributes,
      :start_time => start_time,
      :end_time => end_time,
      :type => type,
    }
  end
  
  # a string representation of the required dimensions for the banner image
  def banner_dimensions_string
    "#{BANNER_WIDTH}x#{BANNER_HEIGHT}"
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
  
  private 
  
    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_banner_dimensions
      dimensions = Paperclip::Geometry.from_file(banner.to_file(:original))
      errors.add(:banner, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{banner_dimensions_string}") unless dimensions.width == BANNER_WIDTH && dimensions.height == BANNER_HEIGHT
    end
  
    # ensure end time is after start time
    def validate_temporal_sanity
      errors.add(:end_time, "Must be after Start Time.") unless self.start_time < self.end_time
    end
  
end
