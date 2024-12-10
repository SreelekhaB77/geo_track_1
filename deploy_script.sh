
#!/bin/bash

# Variables
REPO_URL="https://github.com/SreelekhaB77/geo_tracker.git" # Replace with your GitHub repo URL
APP_DIR="/home/ubuntu/project/geo_tracker"
RUBY_VERSION="3.2.3"

# Clone the repository
if [ ! -d "$APP_DIR" ]; then
    echo "Cloning repository..."
    git clone $REPO_URL $APP_DIR
else
    echo "Repository already cloned. Pulling latest changes..."
    cd $APP_DIR && git pull origin main
fi

# Navigate to the app directory
cd $APP_DIR



# Start the Sinatra app
echo "Starting Sinatra app..."
nohup ruby app.rb -o 0.0.0.0 &

echo "Sinatra app is deployed and running."

