class Day < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  has_many :notes, :as => :asset
  belongs_to :year

  validates :date, :presence => true
  validates_uniqueness_of :date
  validates :name, :presence => true

  # build and/or link the year model
  before_validation {|record|
    record.year_id = Year.find_or_create_by_id(record.date.year).id
  }
  
  # if we just destroyed is the last day in this year, delete the year
  after_destroy {|record|
    record.year.delete if record.year.days.empty?
  }

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    [
      { :name => :search, :as => :string, :fields => [:name], :wildcard => :both },
      { :name => :created_at, :as => :datetimerange }, 
    ]
  end

end
