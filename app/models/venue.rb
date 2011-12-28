class Venue < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  require 'geocode'
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :name, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true, :format => {:with => /[A-Z][A-Z]/, :message => 'should be the 2 letter short form, i.e. "IL"'}
  validates :zipcode, :presence => true, :format => {:with => /\d\d\d\d\d/, :message => 'should be in the format "12345"'}
  validates :country, :presence => true
  validates :lonlat, :presence => {:message => "Failed to geocode this business. Please check the whole address."}

  before_validation {|record|
    # this is the default country, remove it once we go international
    self.country = 'United States'
    # attempt to geocode the address with google
    record.lonlat = record.address.geocode
    record.errors.add :address1, "Failed to geocode this business. Please check the whole address." unless record.lonlat.present?
  } 

  # returns a single line representation of the address
  def address include_country = false, include_name = false
    # address 2 is the only optional field
    street = address2.present? ? "#{address1}, #{address2}" : "#{address1}"
    # build a single line version of the street address
    address = "#{street}, #{city}, #{state} #{zipcode}"
    # optionally include the country name
    address = "#{address}, #{country}" if include_country
    # optionally include the business name
    address = "#{name}, #{address}" if include_name
    address
  end
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :address1 => address1,
      :address2 => address2,
      :city => city,
      :state => state,
      :zipcode => zipcode,
      :country => country,
      :lonlat => lonlat,
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
