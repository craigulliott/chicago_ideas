class SponsorshipLevel < ActiveRecord::Base
  
  scope :by_name, order('name asc')

end
