class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
    # States that you need to be authenticated to access this controller
  before_action :authenticate_user!
  
  # GET schedules/today
  def today
    # Calculates the system's date
    @today_date = Time.now.strftime("%Y-%m-%d")
    # Joins clients with their respective schedules where the schedule date is
    # the same as the system's
    @schedules = Schedule.joins(:client).where(day: @today_date)
  end
  
  def index
    @schedules = Schedule.where(client_id: params[:client_id])
    @client = Client.find(params[:client_id])
  end

  def show
  end

  def new
    @schedule = Schedule.new
    @client = Client.find(params[:client_id])
  end

  def edit
    @client = Client.find(params[:client_id])
  end

  def create
    @client = Client.find(params[:client_id])
    @schedule = Schedule.new(schedule_params)
    
    # Sets the relationship
    @schedule.client_id = @client.id

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to client_schedules_path(@client), notice: 'Se agregó el horario satisfactoriamente' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new, notice: 'El horario no pudo ser agregado' }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @client = Client.find(params[:client_id])
    @schedule.client_id = @client.id
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to client_schedules_path(@client), notice: 'Se actualizó el horario satisfactoriamente' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit, notice: 'El horario no pudo ser actualizado' }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def schedule_params
      params.require(:schedule).permit(:day, :hour, :place, :client_id)
    end
end
