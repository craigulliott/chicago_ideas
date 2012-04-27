class TalkPhoto < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  belongs_to :talk
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  PHOTO_WIDTH = 1360 
  PHOTO_HEIGHT = 800

  validate :validate_photo_dimensions, :unless => "errors.any?"
  
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
  has_attached_file :photo,
    :styles => { 
      :thumb => "145x95#", 
      :album => "680x400#",
      :full => "1360x800#",
    },
    :convert_options => { 
      :thumb => "-quality 70", 
      :album => "-quality 70", 
      :full => "-quality 70",
    },
    :path => 'talk-photos/:style/:id.:extension'

  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.underscore.downcase,
      :photo => photo,
      :talk => talk.api_attributes,
      :caption => caption,
    }
  end
  
  # a string representation of the required dimensions for the photo
  def self.photo_dimensions_string
    "#{PHOTO_WIDTH}x#{PHOTO_HEIGHT}"
  end

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :created_at, :as => :datetimerange }, 
      ]
    end
  end
  
  private
    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_photo_dimensions
      dimensions = Paperclip::Geometry.from_file(photo.to_file(:original))
      errors.add(:photo, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{self.photo_dimensions_string}") unless dimensions.width >= PHOTO_WIDTH && dimensions.height >= PHOTO_HEIGHT
    end
 
end
