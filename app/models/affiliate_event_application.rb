class AffiliateEventApplication < ActiveRecord::Base

  include SearchSortPaginate

  belongs_to :user
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :organization_name, :presence => true
  validates :email, :presence => true
  validates :phone_number, :presence => true
  validates :user_id, :presence => true
  
end
