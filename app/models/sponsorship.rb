class Sponsorship < ActiveRecord::Base
  belongs_to :sponsorship_level
  
  scope :by_sort, order('sort asc')
  
  # when this model is created, set the sort order to the last in the current set (unless it was already set)
  before_validation {|record|
    return true if record.sort.present?
    record.sort = Sponsorship.maximum(:sort).to_i + 1
  }
  
  # Sort the model records all at once
  def self.sort(ids)
    update_all(
      ['sort = FIND_IN_SET(id, ?)', ids.join(',')],
      { :id => ids }
    )
  end
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :name => name,
      :sort => sort,
    }
  end
  
end
