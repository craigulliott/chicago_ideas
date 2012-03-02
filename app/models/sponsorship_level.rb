class SponsorshipLevel < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  has_many :sponsors
  
  scope :by_name, order('name asc')
  scope :by_sort, order('sort asc')
  
  validates :name, :presence => true, :uniqueness => true
  validates :sort, :presence => true, :uniqueness => true
  
  # when this model is created, set the sort order to the last in the current set (unless it was already set)
  before_validation {|record|
    return true if record.sort.present?
    record.sort = SponsorshipLevel.maximum(:sort).to_i + 1
  }
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.underscore.downcase,
      :name => name,
      :sort => sort,
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
  
end
