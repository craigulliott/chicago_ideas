class Sponsor < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  LOGO_WIDTH = 260
  LOGO_HEIGHT = 260

  belongs_to :sponsorship_level
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :sponsorship_level_id, :presence => true
  validates :name, :presence => true, :uniqueness => true
  validate :validate_logo_dimensions, :if => "logo.present?", :unless => "errors.any?"
  
  scope :by_name, order('name asc')
  scope :featured_sponsors, :conditions => { :featured => true }
  scope :by_sort, order('sort asc')
  
  # when this model is created, set the sort order to the last in the current set (unless it was already set)
  before_validation {|record|
    return true if record.sort.present?
    record.sort = Sponsor.maximum(:sort).to_i + 1
  }
  
  # Sort the model records all at once
  def self.sort(ids)
    update_all(
      ['sort = FIND_IN_SET(id, ?)', ids.join(',')],
      { :id => ids }
    )
  end
  
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
  has_attached_file :logo,
    :styles => { 
      :full => "260x260",
    },
    :convert_options => { 
        :full => "-quality 70", 
    },
    
    :path => "sponsor-logos/:style/:id.:extension"


  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :description => description,
      :sponsorship_level => sponsorship_level.api_attributes,
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
  
  # a string representation of the required dimensions for the logo image
  def logo_dimensions_string
    "#{LOGO_WIDTH}x#{LOGO_HEIGHT}"
  end
  
  # parses the description wih markdown and returns html
  def description_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :no_links => true, :hard_wrap => true)
    markdown.render(description).html_safe
  end
  
  private 

    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_logo_dimensions
      dimensions = Paperclip::Geometry.from_file(logo.to_file(:original))
      errors.add(:logo, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{logo_dimensions_string}") unless dimensions.width == LOGO_WIDTH && dimensions.height == LOGO_HEIGHT
    end

end
