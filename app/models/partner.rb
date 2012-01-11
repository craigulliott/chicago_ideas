class Partner < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  BANNER_WIDTH = 1400
  BANNER_HEIGHT = 430
  
  LOGO_WIDTH_OPTION1 = 300
  LOGO_HEIGHT_OPTION1 = 300
  
  LOGO_WIDTH_OPTION2 = 400
  LOGO_HEIGHT_OPTION2 = 200

  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :name, :presence => true, :uniqueness => true
  validate :validate_banner_dimensions, :if => "banner.present?", :unless => "errors.any?"
  validate :validate_logo_dimensions, :if => "logo.present?", :unless => "errors.any?"
  
  scope :by_name, order('name asc')
  
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
  has_attached_file :logo,
    :fog_directory => "#{S3_NAMESPACE}-chicago-ideas-partner-logos",
    :path => ":id.:extension"

  
  # large format blessed photo for the website
  has_attached_file :banner,
    :fog_directory => "#{S3_NAMESPACE}-chicago-ideas-partner-banners",
    :path => ":id.:extension"

  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :description => description,
      :logo => logo,
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
  
  # a string representation of the required dimensions for the logo image
  def logo_dimensions_string
    "#{LOGO_WIDTH_OPTION1}x#{LOGO_HEIGHT_OPTION1} or #{LOGO_WIDTH_OPTION2}x#{LOGO_HEIGHT_OPTION2}"
  end
  
  # parses the description wih markdown and returns html
  def description_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :no_links => true, :hard_wrap => true)
    markdown.render(description).html_safe
  end
  
  private 

    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_banner_dimensions
      dimensions = Paperclip::Geometry.from_file(banner.to_file(:original))
      errors.add(:banner, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{banner_dimensions_string}") unless dimensions.width == BANNER_WIDTH && dimensions.height == BANNER_HEIGHT
    end
  
    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_logo_dimensions
      dimensions = Paperclip::Geometry.from_file(logo.to_file(:original))
      errors.add(:logo, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{logo_dimensions_string}") unless (dimensions.width == LOGO_WIDTH_OPTION1 && dimensions.height == LOGO_HEIGHT_OPTION1) or (dimensions.width == LOGO_WIDTH_OPTION2 && dimensions.height == LOGO_HEIGHT_OPTION2)
    end

end
