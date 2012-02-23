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
  validates :email, :presence => true
  validates :phone_number, :presence => true
  validates :event_name, :presence => true
  validates :event_date, :presence => true
  validates :event_location, :presence => true
  validates :event_capacity, :presence => true
  validates :event_overview, :presence => true
  validates :description_25words, :presence => true
  validates :description_10words, :presence => true
  validates :promote_event, :acceptance => {:accept => true}
  validates :event_info_available, :acceptance => {:accept => true}
  validates :not_make_changes, :acceptance => {:accept => true}
  
end
