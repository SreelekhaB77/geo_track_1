FROM public.ecr.aws/docker/library/ruby:3.2



RUN apt-get update -qq && apt-get install -y nginx

# Set working directory
WORKDIR /app

# Copy all your app files into container
COPY . /app

# Install Ruby gems if you have a Gemfile
# (If no Gemfile, you can skip)
RUN if [ -f "Gemfile" ]; then bundle install; fi

# Expose port
EXPOSE 80

# Start the Ruby app and Nginx together
CMD ruby app.rb
