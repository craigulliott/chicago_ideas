class User < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  # chainable arel method and a boolean helper to determine if models are deleted or not
  include DeleteByTime
  
  PORTRAIT_WIDTH = 468
  PORTRAIT_HEIGHT = 468
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset

  has_many :quotes
  accepts_nested_attributes_for :quotes, :allow_destroy => true

  # useful scopes
  scope :admin, :conditions => { :admin => true }
  scope :speaker, :conditions => { :speaker => true }
  scope :volunteer, :conditions => { :volunteer => true }
  scope :staff, :conditions => { :staff => true }
  
  scope :by_name, order('name asc')
  
  # if a temporary_password is provided, a random password will be generated
  # this random password will be sent to the welcome email, so we can notify the user of it
  attr_accessor :temporary_password
  
  # devise modules
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable 
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :title, :bio, :twitter_screen_name, :portrait, :portrait2, :quotes_attributes

  # validators
  validates :email, :email => { :validate_mx => false }, :presence => true
  validates :name, :presence => true
  
  # welcome emails have a link which signs the user in automatically
  before_create :ensure_authentication_token
  
  # did we use a temporary password when creating this user?
  before_validation :assign_temporary_password, :on => :create
  def assign_temporary_password 
    self.password = self.temporary_password if self.temporary_password.present?
  end
  
  # if the email address is the DEVELOPER_EMAIL then make them the admin (very useful for the creation of the first user)
  before_validation {|record|
    record.admin = true if record.email == ENV['DEVELOPER_EMAIL']
  }

  # clean up/normalize the twitter handle
  before_validation {|record|
    # normalize the twitter name (some people enter @screenname and other just enter screenname - we strip the @)
    record.twitter_screen_name = record.twitter_screen_name[1..9999] if record.twitter_screen_name.present? && record.twitter_screen_name[0] == '@'
    
    # generate an availiable and sensible permalink (unless one already exists)
    unless record.permalink.present?
      permalink = name.gsub(' ', '_').gsub(/[^\w\d_]/, '').downcase
      # if it already exists, then add a number
      i = nil
      if User.find_by_permalink("#{permalink}#{i}").present?
        i = (i||0)+1
      end
      record.permalink = permalink
    end
  }
  
  # send out the welcome email
  after_create {|user|
    #ApplicationMailer.welcome(user).deliver unless Rails.env == 'test'
  }

  validates :permalink, :presence => true, :uniqueness => true, :format => {:with => /^[\w\d_]+$/}
  validate :validate_portrait_dimensions, :if => "portrait.present?", :unless => "errors.any?"
  
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
  has_attached_file :portrait,
    :styles => { 
      :tiny_thumb => "60x60", 
      :thumb => "117x117", 
      :medium => "234x234",
      :full => "468x468",
    },
    :fog_directory => "#{S3_NAMESPACE}-chicago-ideas-speaker-portraits",
    :path => ":style/:id.:extension"
  
  has_attached_file :portrait2,
    :styles => { 
      :tiny_thumb => "60x60", 
      :thumb => "117x117", 
      :medium => "234x234",
      :full => "468x468",
    },
    :fog_directory => "#{S3_NAMESPACE}-chicago-ideas-speaker-alternative-portraits",
    :path => ":style/:id.:extension"

  # an array representing this users special permissiond (tags) used for display purposes
  def access_tags
    tags = []
    tags << 'admin' if admin?
    tags << 'speaker' if speaker?
    tags << 'staff' if staff?
    tags
  end
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
    }
  end

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :search, :as => :string, :fields => [:email, :name], :wildcard => :both },
        { :name => :created_at, :as => :datetimerange }, 
        { :name => :staff, :field => :staff, :as => :boolean, :true_label => 'Yes', :false_label => 'No' }, 
        { :name => :admin, :field => :admin, :as => :boolean, :true_label => 'Yes', :false_label => 'No' }, 
        { :name => :speaker, :field => :speaker, :as => :boolean, :true_label => 'Yes', :false_label => 'No' }, 
      ]
    end
  end

  # we dont store the first name and last name seperately, so these convinience methods allow us to still use them
  def first_name
    name.split(' ').first
  end
  def last_name
    name.split(' ').last
  end
    
  # has this user connected to facebook
  def connected_to_facebook?
    fb_uid && fb_access_token
  end

  # facebook profile picture
  def facebook_profile_pic_src
    connected_to_facebook? ? "https://graph.facebook.com/#{fb_uid}/picture" : nil
  end

  # has this user connected to twitter
  def connected_to_twitter?
    twitter_token && twitter_secret
  end
  
  # a string representation of the required dimensions for the portrait image
  def portrait_dimensions_string
    "#{PORTRAIT_WIDTH}x#{PORTRAIT_HEIGHT}"
  end
  
  # parses the description wih markdown and returns html
  def bio_html
    return nil unless bio.present?
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :no_links => true, :hard_wrap => true)
    markdown.render(bio).html_safe
  end
  
  def bio_abbreviated
    ( bio.present? && bio.length > 200 ) ? "#{bio[0..200]}..." : bio
  end
  
  private 

    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_portrait_dimensions
      dimensions = Paperclip::Geometry.from_file(portrait.to_file(:full))
      errors.add(:portrait, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{portrait_dimensions_string}") unless dimensions.width == PORTRAIT_WIDTH && dimensions.height == PORTRAIT_HEIGHT
    end

    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_portrait2_dimensions
      dimensions = Paperclip::Geometry.from_file(portrait2.to_file(:full))
      errors.add(:portrait2, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{portrait_dimensions_string}") unless dimensions.width == PORTRAIT_WIDTH && dimensions.height == PORTRAIT_HEIGHT
    end

end