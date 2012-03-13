class Job < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  scope :published, where(:published => true)

  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :title => title,
      :body => body,
      :url => url,
      :published => published,
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
