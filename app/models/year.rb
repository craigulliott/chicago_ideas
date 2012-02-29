class Year < ActiveRecord::Base
  has_many :days
  
    def api_attributes
    {
      :id => id.to_s
      
    }
  end
  
end
