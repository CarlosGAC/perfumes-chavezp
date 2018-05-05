class BackupsController < ApplicationController
  def index
    
  end
  
  def call_dump
    %x(bundle exec rake db:dump)
    redirect_to backups_index_path, notice: 'La cuenta se creó satisfactoriamente. Se actualizó el stock'
  end
  
  def call_restore
    %x(bundle exec rake db:restore filename=#{params[:Archivo]})
    redirect_to backups_index_path, notice: 'La cuenta se creó satisfactoriamente. Se actualizó el stock'
  end
end