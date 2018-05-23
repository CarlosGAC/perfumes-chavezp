class BackupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    
  end
  
  def call_dump
    %x(bundle exec rake db:dump)
    send_file("#{Rails.root}/db/backups/perfumeschavez.sql")
    puts "#{Rails.root}/db/backups/perfumeschavez.sql"
    redirect_to backups_index_path, notice: 'El respaldo se creó satisfactoriamente'
  end
  
  def call_restore
    %x(bundle exec rake db:restore)
    redirect_to backups_index_path, notice: 'Se restauró la base de datos satisfactoriamente'
  end
end