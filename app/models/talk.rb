class Talk < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  define_index do
    indexes name
    indexes description
    indexes sponsor(:name), :as => :sponsor, :sortable => true
    has sponsor_id, created_at, updated_at
  end
  
  belongs_to :track
  belongs_to :day
  belongs_to :venue
  belongs_to :sponsor
  belongs_to :talk_brand
  has_many :chapters
  has_many :featured_chapters, :class_name => 'Chapter', :conditions => {:featured_on_talk => true}
  has_many :performances, :through => :chapters
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset

  has_many :talk_photos
  accepts_nested_attributes_for :talk_photos, :allow_destroy => true

  validates :name, :presence => true
  validates :day_id, :presence => true
  validates :venue_id, :presence => true
  validates :talk_brand_id, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true
  validate :validate_temporal_constraints, :unless => "errors.any?"
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :description => description,
      :track => track.present? ? track.api_attributes : "",
      :day => day.present? ? day.api_attributes : "",
      :venue => venue.present? ? venue.api_attributes : "",
      :start_time => start_time,
      :end_time => end_time,
      :sponsor => sponsor.present? ? sponsor.api_attributes : "",
      #:type => type
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
  
  # return a banner, from a featured chapter (or nil)
  def banner size = :medium
    chapter = featured_chapters.first
    chapter.present? ? chapter.banner(size) : nil
  end
   
   
  # return formatted time for the front-end
  def formatted_time
    start_time = "#{self.start_time.strftime("%l")} #{self.start_time.strftime("%p")}"
    end_time = "#{self.end_time.strftime("%l")} #{self.end_time.strftime("%p")}"
    "#{start_time} - #{end_time}"
  end
  

  # return a banner, from a featured chapter (or nil)
  def banner_src
    chapter = featured_chapters.first
    chapter.present? ? chapter.banner(:medium) : nil
  end
  

  
  # Need to normalize the search attributes
  def search_attributes
    {:title => self.name, :description => self.description[0..100], :image => self.banner(:thumb)}
  end


  
  private 
  
    def validate_temporal_constraints
      # ensure end time is after start time
      errors.add(:end_time, "Must be after Start Time.") unless self.start_time < self.end_time
    end
    
end