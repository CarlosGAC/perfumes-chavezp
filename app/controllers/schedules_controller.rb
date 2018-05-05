class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /bill/today
  def today
    @today_date = Time.now.strftime("%Y-%m-%d")
    @schedules = Schedule.joins(:client).where(day: @today_date)
  end
  
  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.where(client_id: params[:client_id])
    @client = Client.find(params[:client_id])
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
    @client = Client.find(params[:client_id])
  end

  # GET /schedules/1/edit
  def edit
    @client = Client.find(params[:client_id])
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @client = Client.find(params[:client_id])
    @schedule = Schedule.new(schedule_params)

    @schedule.client_id = @client.id

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to client_schedules_path(@client), notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    @client = Client.find(params[:client_id])
    @schedule.client_id = @client.id
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to client_schedules_path(@client), notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:day, :hour, :place, :client_id)
    end
end
