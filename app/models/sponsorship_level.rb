class SponsorshipLevel < ActiveRecord::Base
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset

  has_many :sponsors

  validates :name, :presence => true
  validates_uniqueness_of :name
  
  # when this model is created, set the sort order to the last in the current set (unless it was already set)
  before_validation {|record|
    return true if record.sort.present?
    record.sort = SponsorshipLevel.maximum(:sort).to_i + 1
  }
  
  scope :by_name, order('name asc')

  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
    }
  end

end
