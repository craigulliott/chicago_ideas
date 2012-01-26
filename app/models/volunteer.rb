class Volunteer < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  belongs_to :user
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
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
  
end
