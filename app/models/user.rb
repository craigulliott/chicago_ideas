class User < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  # chainable arel method and a boolean helper to determine if models are deleted or not
  include DeleteByTime
  
  # we have a polymorphic relationship with notes
  has_one :staff_bio
  has_many :notes, :as => :asset

  # useful scopes
  scope :admin, :conditions => { :admin => true }

  # if a temporary_password is provided, a random password will be generated
  # this random password will be sent to the welcome email, so we can notify the user of it
  attr_accessor :temporary_password
  
  # devise modules
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable 
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  # validators
  validates :email, :email => { :validate_mx => false }, :presence => true
  validates :name, :presence => true
  
  # welcome emails have a link which signs the user in automatically
  before_create :ensure_authentication_token
  
  # did we use a temporary password when creating this user?
  before_validation :assign_temporary_password, :on => :create
  def assign_temporary_password 
    self.password = self.temporary_password if self.temporary_password.present?
    true # always return true, as false from the above conditional will cause validation to fail
  end
  
  # send out the welcome email
  after_create {|user|
    ApplicationMailer.welcome(user).deliver unless Rails.env == 'test'
  }
  
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

end
