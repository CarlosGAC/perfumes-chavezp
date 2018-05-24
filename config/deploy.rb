# config valid for current version and patch releases of Capistrano
lock "~> 3.10.2"

# Capistrano and Github's configuraton
set :application, "perfumes-chavez"
set :repo_url, "git@github.com:CarlosGAC/perfumes-chavezp.git"

set :deploy_to, '/home/deploy/perfumes-chavez'

# append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"