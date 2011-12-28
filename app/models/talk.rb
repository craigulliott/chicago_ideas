class Talk < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  belongs_to :topic
  belongs_to :day
  belongs_to :venue
  belongs_to :sponsor
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :description => description,
      :topic => topic.api_attributes,
      :day => day.api_attributes,
      :venue => venue.api_attributes,
      :start_time => start_time,
      :end_time => end_time,
      :sponsor => sponsor.api_attributes,
      :type => type,
    }
  end

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :search, :as => :string, :fields => [:name], :wildcard => :both },
        { :name => :created_at, :as => :datetimerange }, 
      ]
    end
  end
  
end
