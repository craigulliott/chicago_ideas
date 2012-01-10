class Performance < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  belongs_to :speaker, :class_name => 'User'
  belongs_to :chapter
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates_uniqueness_of :speaker_id, :scope => :chapter_id
  
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :speaker => speaker.api_attributes,
      :chapter => chapter.api_attributes,
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
  
end
