class Year < ActiveRecord::Base
  
  has_many :days
  has_many :speakers, :dependent => :destroy
  has_many :users, :through => :speakers
  
  # Get all years that are not this year - for archived talks
  scope :not_this_year, where("id != #{Time.now.year}")
  
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.underscore.downcase,
      :days => days.present? ? days.collect { |day| day.api_attributes } : []
    }
  end
  
end
