class BackupsController < ApplicationController
  # States that you need to be authenticated to access this controller
  before_action :authenticate_user!
  
  def index
    
  end
  
  # Method controller that executes the custom rake task "db:dump"
  def call_dump
    # Executes the rake task
    %x(bundle exec rake db:dump)
    # Downloads the file into the client machine
    send_file("#{Rails.root}/db/backups/perfumeschavez.sql")
    puts "#{Rails.root}/db/backups/perfumeschavez.sql"
    # Redirects to the backup index
    redirect_to backups_index_path, notice: 'El respaldo se creó satisfactoriamente'
  end
  
  # Method controller that executes the custom rake task "db:restore"
  def call_restore
    # Executes the rake task
    %x(bundle exec rake db:restore)
    # Redirects to the backup index
    redirect_to backups_index_path, notice: 'Se restauró la base de datos satisfactoriamente'
  end
end