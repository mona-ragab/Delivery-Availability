class DeliveryAvailabilityController < ApplicationController
  def home; end

  def delivery_supported
    result = gecoding()
    address = Geokit::LatLng.new(result.latitude, result.longitude)

    polygon_point = [
      {
        lat: 49.297361,
        lng: -123.090682
      },
      {
        lat: 49.250460,
        lng: -123.089365
      },
      {
        lat: 49.218333,
        lng: -122.988255
      },
      {
        lat: 49.248132,
        lng: -122.974992
      },
      {
        lat: 49.285447,
        lng: -122.980697
      },
      {
        lat:49.299671,
        lng: -122.986697

      }
    ]
    polygon_coords = polygon_point.map do |point|
      Geokit::LatLng.new(point[:lat], point[:lng])
    end
    polygon = Geokit::Polygon.new polygon_coords
    delivery_supported = polygon.contains? address
    message(delivery_supported)
    redirect_to '/'
  end

  private

  def gecoding
    Geokit::Geocoders::GoogleGeocoder.api_key = ENV.fetch('API_KEY')
    Geokit::Geocoders::GoogleGeocoder.geocode(params['address'])
  end

  def message(delivery_supported)
    if delivery_supported
      flash[:success] = 'Congratulation you are eligable for free delivery '
    else
      flash[:danger] = 'Sorry, we dont cover your address, please check back later'
    end
  end
end
