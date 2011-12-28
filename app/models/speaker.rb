class Speaker < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  BANNER_WIDTH = 667
  BANNER_HEIGHT = 468
  
  PORTRAIT_WIDTH = 234
  PORTRAIT_HEIGHT = 234
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :name, :presence => true
  validates_uniqueness_of :name
  
  validates :permalink, :presence => true, :uniqueness => true, :format => {:with => /^[\w\d_]+$/}
  validate :validate_banner_dimensions, :unless => "errors.any?"
  validate :validate_portrait_dimensions, :unless => "errors.any?"

  # clean up/normalize the twitter handle
  before_validation {|record|
    # normalize the twitter name (some people enter @screenname and other just enter screenname - we strip the @)
    record.twitter_screen_name = record.twitter_screen_name[1..9999] if record.twitter_screen_name.present? && record.twitter_screen_name[0] == '@'
    
    # generate an availiable and sensible permalink (unless one already exists)
    unless record.permalink.present?
      permalink = name.gsub(' ', '_').gsub(/[^\w\d_]/, '').downcase
      # if it already exists, then add a number
      i = nil
      if Speaker.find_by_permalink("#{permalink}#{i}").present?
        i = (i||0)+1
      end
      record.permalink = permalink
    end
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
    :fog_directory => "chicago-ideas-speaker-banners",
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
  
  # a string representation of the required dimensions for the banner image
  def banner_dimensions_string
    "#{BANNER_WIDTH}x#{BANNER_HEIGHT}"
  end
  
  # a string representation of the required dimensions for the portrait image
  def portrait_dimensions_string
    "#{PORTRAIT_WIDTH}x#{PORTRAIT_HEIGHT}"
  end
  
  # parses the description wih markdown and returns html
  def bio_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :no_links => true, :hard_wrap => true)
    markdown.render(bio).html_safe
  end
  
  private 

    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_banner_dimensions
      dimensions = Paperclip::Geometry.from_file(banner.to_file(:original))
      errors.add(:banner, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{banner_dimensions_string}") unless dimensions.width == BANNER_WIDTH && dimensions.height == BANNER_HEIGHT
    end

    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_portrait_dimensions
      dimensions = Paperclip::Geometry.from_file(portrait.to_file(:original))
      errors.add(:portrait, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{portrait_dimensions_string}") unless dimensions.width == PORTRAIT_WIDTH && dimensions.height == PORTRAIT_HEIGHT
    end

end
