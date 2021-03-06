class OrderAddress
  attr_reader :place_id

  def initialize(place_id)
    @place_id = place_id
    client = GooglePlaces::Client.new(ENV.fetch("GOOGLE_API_KEY"))
    @spot = client.spot(place_id).address_components
  end

  def country
    @spot.detect { |component| component["types"].include?("country") }["long_name"]
  end

  def postal_code
    @spot.detect { |component| component["types"].include?("postal_code") }["long_name"]
  end
end
