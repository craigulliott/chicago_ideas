# Craig Ulliott
# geocode a string, and return a latlon hash
class String

  # sends this string to google geocoder, parses the response and returns a Point
  def geocode street_only = true
    begin
      address = self
      response = HTTParty.get('http://maps.googleapis.com/maps/api/geocode/json', :format => :json, :query => {:address => address, :sensor => 'false'})
      if street_only and response["results"][0]["types"][0] != "street_address" and response["results"][0]["types"][0] != "subpremise"
        raise 'not enough accuracy from results'
      end
      latlon = response["results"][0]["geometry"]["location"]
      return Point.from_x_y latlon["lng"], latlon["lat"]
    rescue
      return nil
    end
  end
  
end