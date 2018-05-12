class BackupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    
  end
  
  def call_dump
    %x(bundle exec rake db:dump)
    send_file("#{Rails.root}/db/backups/perfumeschavez.sql")
    puts "#{Rails.root}/db/backups/perfumeschavez.sql"
    #redirect_to backups_index_path, notice: 'La cuenta se creó satisfactoriamente. Se actualizó el stock'
  end
  
  def call_restore
    %x(bundle exec rake db:restore)
    redirect_to backups_index_path, notice: 'La cuenta se creó satisfactoriamente. Se actualizó el stock'
  end
end