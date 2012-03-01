class Year < ActiveRecord::Base
  has_many :days
  
    def api_attributes
    {
      :id => id.to_s,
      :days => days.present? ? days.collect { |day| day.api_attributes } : []
    }
  end
  
end
