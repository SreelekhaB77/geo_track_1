# testing2
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
  user_ip = '8.8.8.8' if user_ip == '34.229.146.80'

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


# Webhook listener for GitHub events
post '/webhook' do
  # Verify the webhook signature
  request_body = request.body.read
  secret = ENV['08fcff977a287a55c9d921779171886c1edffe3e']  # Secret token set in your environment
  signature = 'sha256=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, request_body)

  halt 403, "Invalid signature" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE_256'])

  # Process the webhook payload
  payload = JSON.parse(request_body)
  if payload['ref'] == 'refs/heads/main'  # Check for pushes to the main branch
    system("cd /home/ubuntu/project/geo_tracker && git pull origin main && bundle install && restart_app.sh")
  end

  "Webhook received and processed!"
end
