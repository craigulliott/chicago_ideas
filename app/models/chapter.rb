class Chapter < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  belongs_to :talk
  has_many :performances
  accepts_nested_attributes_for :performances, :allow_destroy => true
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :sort, :presence => true
  validates_uniqueness_of :sort, :scope => :talk_id
  
  scope :by_sort, order('sort asc')
  
  # when this model is created, set the sort order to the last in the current set (unless it was already set)
  before_validation {|record|
    return true if record.sort.present?
    record.sort = Chapter.where(:talk_id => record.talk_id).maximum(:sort).to_i + 1
  }
  
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
  
end
