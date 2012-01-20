class Chapter < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  BANNER_WIDTH = 1400
  BANNER_HEIGHT = 676

  belongs_to :talk
  has_many :performances
  has_many :speakers, :through => :performances
  accepts_nested_attributes_for :performances, :allow_destroy => true

  has_many :chapter_photos
  accepts_nested_attributes_for :chapter_photos, :allow_destroy => true
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :sort, :presence => true
  validates_uniqueness_of :sort, :scope => :talk_id
  validate :validate_banner_dimensions, :if => "banner.present?", :unless => "errors.any?"
  
  scope :by_sort, order('sort asc')
  
  # when this model is created, set the sort order to the last in the current set (unless it was already set)
  before_validation {|record|
    return true if record.sort.present?
    record.sort = Chapter.where(:talk_id => record.talk_id).maximum(:sort).to_i + 1
  }
  
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
  # large format blessed photo for the website
  has_attached_file :banner,
    :styles => { 
      :large => "1400x676", 
      :medium => "1000x483#",
      :small => "300x144#",
      :thumb => "110x65#",
    },
    :path => "chapter-banners/:style/:id.:extension"
  
  # a string representation of the required dimensions for the banner image
  def banner_dimensions_string
    "#{BANNER_WIDTH}x#{BANNER_HEIGHT}"
  end
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :sort => sort,
      :title => title,
      :description => description,
      :talk => talk.api_attributes,
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
  
  private 

    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_banner_dimensions
      dimensions = Paperclip::Geometry.from_file(banner.to_file(:original))
      errors.add(:banner, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{banner_dimensions_string}") unless dimensions.width == BANNER_WIDTH && dimensions.height == BANNER_HEIGHT
    end
  
end
