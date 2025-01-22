directory '/home/ubuntu/geo_track_1'
rackup "config.ru"
environment 'production'

threads 4, 8
workers 2
preload_app!

bind "unix:///home/ubuntu/geo_track_1/tmp/puma/socket"
pidfile "/home/ubuntu/geo_track_1/tmp/puma/pid"
state_path "/home/ubuntu/geo_track_1/tmp/puma/state"
stdout_redirect "/home/ubuntu/geo_track_1/log/puma.stdout.log", "/home/ubuntu/geo_track_1/log/puma.stderr.log", true


# Add this line to set proper permissions:
permissions_mode = 0o777
 

