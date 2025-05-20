directory '/app'
rackup "config.ru"
environment 'production'

threads 4, 8
workers 2
preload_app!

#bind "unix:///app/tmp/puma/socket"
bind "tcp://0.0.0.0:9292"
pidfile "/app/tmp/puma/pid"
state_path "/app/tmp/puma/state"
stdout_redirect "/app/log/puma.stdout.log", "/app/log/puma.stderr.log", true

permissions_mode = 0o777

