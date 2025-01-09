directory '/home/ubuntu/geo_tracker'
rackup "config.ru"
environment 'production'

threads 4, 8
workers 2
preload_app!

bind "unix:///home/ubuntu/geo_tracker/tmp/puma/socket"
pidfile "/home/ubuntu/geo_tracker/tmp/puma/pid"
state_path "/home/ubuntu/geo_tracker/tmp/puma/state"
stdout_redirect "/home/ubuntu/geo_tracker/log/puma.stdout.log", "/home/ubuntu/geo_tracker/log/puma.stderr.log", true


# Add this line to set proper permissions:
permissions_mode = 0o777
 

