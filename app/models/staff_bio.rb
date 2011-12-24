class StaffBio < ActiveRecord::Base
  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  belongs_to :user
  
  validates :user_id, :presence => true
  validates :sort, :presence => true, :numericality => {:greater_than => 0}
  validates :title, :presence => true
  validates :about, :presence => true
  
  scope :by_sort_column, order('sort asc')
  
  # when this model is created, set the sort order to the last in the current set (unless it was already set)
  before_validation {|record|
    return true if record.sort.present?
    record.sort = StaffBio.maximum(:sort).to_i + 1
  }
  
  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    [
      { :name => :search, :as => :string, :fields => [:title, :about], :wildcard => :both },
    ]
  end

end
