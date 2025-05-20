FROM public.ecr.aws/docker/library/ruby:3.2

# Install dependencies and NGINX
RUN apt-get update -qq && \
    apt-get install -y nginx supervisor build-essential libpq-dev nodejs

# Set working directory
WORKDIR /app

# Copy app files
COPY . /app


RUN mkdir -p /app/tmp/puma /app/log


# Install Ruby dependencies
RUN if [ -f "Gemfile" ]; then bundle install; fi

# Copy NGINX config (we'll define this below)
COPY nginx.conf /etc/nginx/nginx.conf

# Copy Supervisor config (for running both processes)
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose HTTP port
EXPOSE 80

# Run both nginx and ruby app with supervisord
CMD ["/usr/bin/supervisord"]
