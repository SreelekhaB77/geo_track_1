#require 'puma/daemon'
root = "#{Dir.getwd}"
p root
bind "unix://#{root}/tmp/puma/socket_3"
pidfile "#{root}/tmp/puma/pid"
state_path "#{root}/tmp/puma/state"
rackup "#{root}/config.ru"
stdout_redirect '/opt/nginx/logs/puma.log', '/opt/nginx/logs/puma_error.log', true
 
# Configure “min” to be the minimum number of threads to use to answer
# requests and “max” the maximum.
# The default is “0, 16”.
threads 4, 8
 
# === Cluster mode ===
# How many worker processes to run.
# The default is “0”.
workers 2
 
# quiet
# config.logger = Logger.new(STDOUT)
on_worker_boot do
  # configuration here
end
 
 
activate_control_app
# daemonize true
#
#
 

