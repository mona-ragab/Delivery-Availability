class DeliveryAvailabilityController < ApplicationController
  def home; end

  def delivery_supported
    result = gecoding()
    address = Geokit::LatLng.new(result.latitude, result.longitude)

    polygon_point = [
      {
        lat: 49.252311,
        lng: -123.045680
      },
      {
        lat: 49.256240,
        lng: -123.020976
      },
      {
        lat: 49.242627,
        lng: -123.014273
      },
      {
        lat: 49.230514,
        lng: -123.015907
      },
      {
        lat: 49.230661,
        lng: -123.050476
      },
      {
        lat: 49.248511,
        lng: -123.089339
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
