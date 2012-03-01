class Volunteer < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  belongs_to :user
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :hours, :presence => true
  validates :user_id, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates :phone, :presence => true
  validates :why, :presence => true
  validates :what, :presence => true
  validates :availability, :presence => true
  
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.underscore.downcase,
      :user => user.api_attributes,
      :postcode => postcode,
      :employed => employed,
      :why => why,
      :what => what,
      :availability => availability,
      :street_team => street_team,
      :avail_mon => avail_mon,
      :avail_tue => avail_tue,
      :avail_wed => avail_wed,
      :avail_thu => avail_thu,
      :avail_fri => avail_fri,
      :avail_sat => avail_sat,
      :avail_sun => avail_sun,
      :avail_time_1 => avail_time_1,
      :avail_time_2 => avail_time_2,
      :avail_time_3 => avail_time_3,
      :avail_time_4 => avail_time_4,
      :avail_time_5 => avail_time_5,
      :avail_time_6 => avail_time_6,
      :hours => hours,
    }
  end

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :created_at, :as => :datetimerange }, 
      ]
    end
  end
  
  def available_days
    days = []
    days << "monday" if avail_mon?
    days << "tuesday" if avail_tue?
    days << "wednesday" if avail_wed?
    days << "thursday" if avail_thu?
    days << "friday" if avail_fri?
    days << "saturday" if avail_sat?
    days << "sunday" if avail_sun?
    days
  end
  
  def available_times
    days = []
    days << "8am - 1pm" if avail_time_1?
    days << "10am - 3pm" if avail_time_2?
    days << "12am - 5pm" if avail_time_3?
    days << "2pm - 7pm" if avail_time_4?
    days << "4pm - 9pm" if avail_time_5?
    days << "6pm - 11pm" if avail_time_6?
    days
  end

end
