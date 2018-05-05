class OrderDataController < ApplicationController
  before_action :set_order_datum, only: [:show, :edit, :update, :destroy]
  autocomplete :client, :name

  def alldata
    
  end

  # GET /order_data
  # GET /order_data.json
  def index
    @order_data = OrderDatum.all.order(order_date: :desc)
  end

  # GET /order_data/1
  # GET /order_data/1.json
  def show
  end

  # GET /order_data/new
  def new
    @order_datum = OrderDatum.new
  end

  # GET /order_data/1/edit
  def edit
  end

  # POST /order_data
  # POST /order_data.json
  def create
    @client = Client.where(name: params[:order_datum][:client_name]).first
    @order_datum = OrderDatum.new(order_datum_params)
    if !@client.blank?
      @order_datum.client_id = @client.id
      respond_to do |format|
        if @order_datum.save
          format.html { redirect_to @order_datum, notice: 'La orden se creó satisfactoriamente' }
          format.json { render :show, status: :created, location: @order_datum }
        else
          format.html { render :new, notice: 'La orden no pudo ser guardada en la base de datos' }
          format.json { render json: @order_datum.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new, notice: 'El cliente ingresado no es válido'}
        format.json { render json: @order_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_data/1
  # PATCH/PUT /order_data/1.json
  def update
    @client = Client.where(name: params[:order_datum][:client_name]).first
    if !@client.blank?
      @order_datum.client_id = @client.id
      respond_to do |format|
        if @order_datum.update(order_datum_params)
          format.html { redirect_to @order_datum, notice: 'La orden se actualizó satisfactoriamente' }
          format.json { render :show, status: :created, location: @order_datum }
        else
          format.html { render :new, notice: 'La orden no pudo ser actualizada en la base de datos' }
          format.json { render json: @order_datum.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new, notice: 'El cliente ingresado no es válido'}
        format.json { render json: @order_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_data/1
  # DELETE /order_data/1.json
  def destroy
    @order_datum.destroy
    respond_to do |format|
      format.html { redirect_to order_data_url, notice: 'Order datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_order_datum
    @order_datum = OrderDatum.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_datum_params
    params.require(:order_datum).permit(:order_date)
  end
end
