class Speaker < ActiveRecord::Base

    # my bone dry solution to search, sort and paginate
    include SearchSortPaginate

    # we have a polymorphic relationship with notes
    has_many :notes, :as => :asset

    validates :name, :presence => true
    validates_uniqueness_of :name
  
    # clean up/normalize the twitter handle
    before_validation {
      self.twitter_screen_name = self.twitter_screen_name[1..9999] if self.twitter_screen_name.present? && self.twitter_screen_name[0] == '@'
    } 

    # tell the dynamic form that we need to post to an iframe to accept the file upload
    # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
    def accepts_file_upload?
      true
    end

    # note can have attachments
    has_attached_file :portrait,
      :storage => :fog,
      :fog_credentials => {
        :aws_access_key_id => AWS_ACCESS_KEY_ID,
        :aws_secret_access_key => AWS_SECRET_ACCESS_KEY,
        provider: 'AWS',
        region: 'us-east-1'
      },
      :fog_public => false,
      :fog_directory => "ciw-speaker-portraits",
      :path => ":id.:extension"

    # the hash representing this model that is returned by the api
    def api_attributes
      {
        :id => id.to_s,
        :type => self.class.name.downcase,
        :name => name,
        :title => title,
        :twitter_screen_name => twitter_screen_name,
        :facebook_page_id => facebook_page_id,
        :bio => bio,
        :portrait => portrait,
      }
    end

    # a DRY approach to searching lists of these models
    def self.search_fields parent_model=nil
      case parent_model.class.name.underscore
      when 'foo'
      else
        [
          { :name => :search, :as => :string, :fields => [:bio, :name, :title, :twitter_screen_name, :facebook_page_id], :wildcard => :both },
          { :name => :created_at, :as => :datetimerange }, 
        ]
      end
    end

  end
