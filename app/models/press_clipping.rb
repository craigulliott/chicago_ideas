class PressClipping < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  IMAGE_WIDTH = 200 
  IMAGE_HEIGHT = 140
  
  validates :created_at, :presence => true
  validates :title, :presence => true
  validates :url, :format => {:with => URI::regexp(%w(http https)), :message => 'not a valid URL'}, :allow_nil => true
  
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
  has_attached_file :image,
    :fog_directory => "#{S3_NAMESPACE}-chicago-ideas-press-clipping-images",
    :path => ":id.:extension"

  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :title => title,
      :image => image,
      :url => url,
      :description => description,
    }
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
  
  # a string representation of the required dimensions for the image
  def image_dimensions_string
    "#{IMAGE_WIDTH}x#{IMAGE_HEIGHT}"
  end
  
  private
    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_image_dimensions
      dimensions = Paperclip::Geometry.from_file(image.to_file(:original))
      errors.add(:image, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{image_dimensions_string}") unless dimensions.width == IMAGE_WIDTH && dimensions.height == IMAGE_HEIGHT
    end
  
end
