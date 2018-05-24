class OrderDataController < ApplicationController
  before_action :set_order_datum, only: [:show, :edit, :update, :destroy]
    # States that you need to be authenticated to access this controller
  before_action :authenticate_user!
    # Creates the autocomplete controller methods for the client's name
  autocomplete :client, :name
  
  def index
    @order_data = OrderDatum.all.order(order_date: :desc)
  end

  def show
  end

  def new
    @order_datum = OrderDatum.new
  end

  def edit
  end

  def create
    # Gets the client with the given name
    @client = Client.where(name: params[:order_datum][:client_name]).first
    @order_datum = OrderDatum.new(order_datum_params)
    # If the client exists, updates the relationship
    # else, renders the form again and shows an error
    if !@client.blank?
      @order_datum.client_id = @client.id
      respond_to do |format|
        if @order_datum.save
          format.html { redirect_to @order_datum, notice: 'La orden se creó satisfactoriamente' }
          format.json { render :show, status: :created, location: @order_datum }
        else
          format.html { redirect_to new_order_datum_url, notice: 'La orden no pudo ser guardada en la base de datos' }
          format.json { render json: @order_datum.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_order_datum_url, notice: 'El cliente ingresado no es válido'}
        format.json { render json: @order_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # Gets the client with the given name
    @client = Client.where(name: params[:order_datum][:client_name]).first
    if !@client.blank?
      # If the client exists, updates the relationship
      # else, renders the form again and shows an error
      @order_datum.client_id = @client.id
      respond_to do |format|
        if @order_datum.update(order_datum_params)
          format.html { redirect_to @order_datum, notice: 'La orden se actualizó satisfactoriamente' }
          format.json { render :show, status: :created, location: @order_datum }
        else
          format.html { render :edit, notice: 'La orden no pudo ser actualizada en la base de datos' }
          format.json { render json: @order_datum.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :edit, notice: 'El cliente ingresado no es válido'}
        format.json { render json: @order_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def set_order_datum
    @order_datum = OrderDatum.find(params[:id])
  end

  def order_datum_params
    params.require(:order_datum).permit(:order_date)
  end
end
