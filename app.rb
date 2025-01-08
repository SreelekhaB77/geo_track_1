require 'sinatra'
require 'geocoder'
require 'json'
require 'openssl'

# Basic Sinatra configuration
set :port, 4567

# Endpoint to get user location
get '/user_location' do
  # Use request.ip to get the user's IP address
  user_ip = request.ip

  # Fallback IP for local testing (use a real IP when deployed)
   user_ip = '8.8.8.8' if user_ip == '34.238.171.87'

  # Use Geocoder to get location data
  location_data = Geocoder.search(user_ip).first

  if location_data
    {
      ip: user_ip,
      city: location_data.city,
      state: location_data.state,
      country: location_data.country,
      coordinates: location_data.coordinates
    }.to_json
  else
    status 404
    { error: 'Unable to determine location' }.to_json
  end
end
