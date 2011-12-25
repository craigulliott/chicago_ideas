class Topic < ActiveRecord::Base
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  scope :by_name, order('name asc')
  
  validates :name, :presence => true
  validates_uniqueness_of :name
  validates :description, :presence => true

  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :description => description,
    }
  end
  
end
