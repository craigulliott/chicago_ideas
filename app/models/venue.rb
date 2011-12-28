class Venue < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  require 'geocode'
  
  BANNER_WIDTH = 667
  BANNER_HEIGHT = 468
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :name, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true, :format => {:with => /[A-Z][A-Z]/, :message => 'should be the 2 letter short form, i.e. "IL"'}
  validates :zipcode, :presence => true, :format => {:with => /\d\d\d\d\d/, :message => 'should be in the format "12345"'}
  validates :country, :presence => true
  validates :lonlat, :presence => {:message => "Failed to geocode this business. Please check the whole address."}
  validate :validate_banner_dimensions, :if => "banner.present?", :unless => "errors.any?"

  before_validation {|record|
    # attempt to geocode the address with google
    record.lonlat = record.address.geocode
    record.errors.add :address1, "Failed to geocode this business. Please check the whole address." unless record.lonlat.present?
  } 
  
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
    :fog_directory => "#{S3_NAMESPACE}-chicago-ideas-venue-banners",
    :path => ":id.:extension"

  # returns a single line representation of the address
  def address include_country = false, include_name = false
    # address 2 is the only optional field
    street = address2.present? ? "#{address1}, #{address2}" : "#{address1}"
    # build a single line version of the street address
    address = "#{street}, #{city}, #{state} #{zipcode}"
    # optionally include the country name
    address = "#{address}, #{country}" if include_country
    # optionally include the business name
    address = "#{name}, #{address}" if include_name
    address
  end
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :address1 => address1,
      :address2 => address2,
      :city => city,
      :state => state,
      :zipcode => zipcode,
      :country => country,
      :lonlat => lonlat,
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
  
  # a string representation of the required dimensions for the banner image
  def banner_dimensions_string
    "#{BANNER_WIDTH}x#{BANNER_HEIGHT}"
  end
  
  # google powered maps and geocoding
  def position
    "#{lonlat.y},#{lonlat.x}"
  end
  
  def google_maps_src width=280, height=280, maptype=:roadmap, zoom=12
    "http://maps.google.com/maps/api/staticmap?center=#{position}&zoom=#{zoom}&size=#{width}x#{height}&maptype=#{maptype}&markers=color:blue%7Clabel:A%7C#{position}&sensor=false"
  end
  
  def google_maps_url
    "http://maps.google.com/maps?hl=en&q=#{position}"
  end
  
  private 
    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_banner_dimensions
      dimensions = Paperclip::Geometry.from_file(banner.to_file(:original))
      errors.add(:banner, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{banner_dimensions_string}") unless dimensions.width == BANNER_WIDTH && dimensions.height == BANNER_HEIGHT
    end
  
end
