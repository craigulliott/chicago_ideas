class Event < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  BANNER_WIDTH = 1400
  BANNER_HEIGHT = 500
  
  LAB_HOST_WIDTH = 260
  LAB_HOST_HEIGHT = 260
  
  define_index do
    indexes name
    indexes description
  end


  belongs_to :partner
  belongs_to :day
  belongs_to :venue
  belongs_to :event_brand
  
  has_many :event_photos
  accepts_nested_attributes_for :event_photos, :allow_destroy => true
  
  has_many :event_speakers
  has_many :speakers, :through => :event_speakers
  accepts_nested_attributes_for :event_speakers, :allow_destroy => true

  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :name, :presence => true
  validates :day_id, :presence => true
  validates :venue_id, :presence => true
  validates :event_brand_id, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true
  validate :validate_banner_dimensions, :if => "banner.present?", :unless => "errors.any?"
  validate :validate_lab_host_dimensions, :if => "lab_host.present?", :unless => "errors.any?"
  validate :validate_temporal_sanity, :unless => "errors.any?"
  
  scope :archived, joins(:day).where("days.year_id != #{DateTime.now.year}")
  scope :current, joins(:day).where("days.year_id = #{DateTime.now.year}")
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
  # large format blessed photo for the website
  has_attached_file :banner,
    :styles => { 
      :large => "1400x500", 
      :medium => "1000x357#",
      :thumb => "300x107#",
    },
    :convert_options => { 
      :large => "-quality 70", 
      :medium => "-quality 70", 
      :thumb => "-quality 70",
    },
    :path => "event-banners/:style/:id.:extension"
    
  has_attached_file :lab_host,
    :styles => { 
      :large => "260x260", 
    },
    :convert_options => { 
      :large => "-quality 70", 
    },
    :path => "event-lab-host/:style/:id.:extension"
      
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.underscore.downcase,
      :name => name,
      :description => description,
      :partner => partner.present? ? partner.api_attributes : "",
      :day => day.present? ? day.api_attributes : "",
      :venue => venue.present? ? venue.api_attributes : "",
      :event_type => event_brand.present? ? event_brand.api_attributes : "",
      :banner => banner.url,
      :lab_host => lab_host.url,
      :start_time => start_time,
      :end_time => end_time,
    }
  end
  
  # a string representation of the required dimensions for the banner image
  def banner_dimensions_string
    "#{BANNER_WIDTH}x#{BANNER_HEIGHT}"
  end
  
  def lab_host_dimensions_string
    "#{LAB_HOST_WIDTH}x#{LAB_HOST_HEIGHT}"
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
  
  # return formatted date for the front-end
  def formatted_date
    "#{self.day.date.strftime("%A, %B %e, %Y")}"
  end
  
  # return formatted time for the front-end
  def formatted_time
    start_time = "#{self.start_time.strftime("%l:%M")} #{self.start_time.strftime("%p")}"
    end_time = "#{self.end_time.strftime("%l:%M")} #{self.end_time.strftime("%p")}"
    "#{start_time} - #{end_time}"
  end
  
  def is_current?
    self.day.year_id == DateTime.now.year ? true : false
  end
  

  # Need to normalize the search attributes
  def search_attributes
    {:title => self.name, :description => (!self.description.blank?) ? self.description[0..100] : "", :image => ''}
  end


  private 
  
    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_banner_dimensions
      dimensions = Paperclip::Geometry.from_file(banner.to_file(:original))
      errors.add(:banner, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{banner_dimensions_string}") unless dimensions.width == BANNER_WIDTH && dimensions.height == BANNER_HEIGHT
    end
    
    def validate_lab_host_dimensions
      dimensions = Paperclip::Geometry.from_file(lab_host.to_file(:original))
      errors.add(:lab_host, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{lab_host_dimensions_string}") unless dimensions.width == LAB_HOST_WIDTH && dimensions.height == LAB_HOST_HEIGHT
    end
  
    # ensure end time is after start time
    def validate_temporal_sanity
      errors.add(:end_time, "Must be after Start Time.") unless self.start_time < self.end_time
    end
  
end
