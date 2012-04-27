class Chapter < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  BANNER_WIDTH = 1400
  BANNER_HEIGHT = 676
  
  define_index do
    indexes name
    indexes description
    indexes talk(:name), :as => :talk, :sortable => true
    has talk_id, created_at, updated_at
    group_by "talk_id"
  end
  
  
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
  validate :validate_homepage_banner_dimensions, :if => "homepage_banner.present?", :unless => "errors.any?"
  
  scope :by_sort, order('sort asc')
  
  # Get current or archived chapters
  scope :current, joins(:talk => [:day]).where("days.year_id = #{DateTime.now.year}")
  scope :archived, joins(:talk => [:day]).where("days.year_id != #{DateTime.now.year}")
  
  scope :talk_featured, :conditions => {:featured_on_talk => true}
  scope :homepage_featured, :conditions => {:featured_on_homepage => true}
  
  # Simple way to separate current chapters from archived
  #scope :current, joins(Talk).where('id = self.talk_id').joins(:day).where("days.year_id != #{DateTime.now.year}")
  
  #scope :current, joins(self.Talk.years).where("years.id = #{DateTime.now.year}")
  #scope :current, 
  #scope :archived, joins(:years).where("years.id != #{DateTime.now.year}")
  
  
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
  
  
  # Check if it's a current year chapter
  def is_current?
    talk = Talk.find(self.talk_id)
    return talk.day.year_id == DateTime.now.year ? true : false
    #self.Talk.days.year_id == DateTime.now.year ? true : false
    #self.day.year_id == DateTime.now.year ? true : false
  end
  

  
  # large format blessed photo for the website
  has_attached_file :banner,
    :styles => { 
      :large => "1400x676", 
      :medium => "1000x483#",
      :small => "300x144#",
      :thumb => "110x65#",
    },
    :convert_options => { 
      :large => "-quality 70", 
      :medium => "-quality 70", 
      :small => "-quality 70",
      :thumb => "-quality 70",
    },
    :path => "chapter-banners/:style/:id.:extension"
  
  # optional large format blessed photo for the homepage
  has_attached_file :homepage_banner,
    :styles => { 
      :large => "1400x676", 
      :medium => "1000x483#",
      :small => "300x144#",
      :thumb => "110x65#",
    },
    :convert_options => { 
      :large => "-quality 70", 
      :medium => "-quality 70", 
      :small => "-quality 70",
      :thumb => "-quality 70",
    },
    :path => "chapter-homepage-banners/:style/:id.:extension"
  
  # a string representation of the required dimensions for the banner image
  def banner_dimensions_string
    "#{BANNER_WIDTH}x#{BANNER_HEIGHT}"
  end
  
  # the hash representing this model that is returned by the api
  def api_attributes(ref = nil)
    {
      :id => id.to_s,
      :type => self.class.name.underscore.downcase,
      :sort => sort,
      :title => title,
      :description => description,
      :talk => talk.present? ? ref != 'talk' ? talk.api_attributes : '' : "",
      :video => vimeo_id,
      :featured_on_talk => featured_on_talk,
      :featured_on_homepage => featured_on_homepage,
      :homepage_caption => homepage_caption,
      :banner => banner.url,
      :performances => performances.present? ? performances.collect{|p| p.api_attributes('chapters') } : "",
      :homepage_banner_file_name => homepage_banner_file_name,
      :homepage_banner_content_type => homepage_banner_content_type,
      :homepage_banner_file_size => homepage_banner_file_size,
      :homepage_banner_updated_at => homepage_banner_updated_at
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


  # Need to normalize the search attributes
  def search_attributes
    {:title => self.title, :description => self.description[0..100], :image => self.banner(:thumb)}
  end
  
  
  
  
  
  private 

    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_banner_dimensions
      dimensions = Paperclip::Geometry.from_file(banner.to_file(:original))
      errors.add(:banner, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{banner_dimensions_string}") unless dimensions.width == BANNER_WIDTH && dimensions.height == BANNER_HEIGHT
    end

    def validate_homepage_banner_dimensions
      dimensions = Paperclip::Geometry.from_file(homepage_banner.to_file(:original))
      errors.add(:homepage_banner, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{banner_dimensions_string}") unless dimensions.width == BANNER_WIDTH && dimensions.height == BANNER_HEIGHT
    end
  
end
