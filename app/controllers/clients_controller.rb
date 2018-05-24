class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update]
    # States that you need to be authenticated to access this controller
  before_action :authenticate_user!
    # Creates the autocomplete controller methods for the postal codes
  autocomplete :postal_code, :c_postal, additional_data: [:settlement, :township, :state, :city]
  
  def index
    # If the controller recieves a param, executes the client search
    # else, it shows all the clients
    if params[:name] or params[:address] or params[:phone_number] or params[:external_address_num] or params[:zipcode] or params[:colony] or params[:city] or params[:state]
      @clients = Client.where('name LIKE ? AND address LIKE ? AND phone_number LIKE ? AND zipcode LIKE ? AND colony LIKE ? AND city LIKE ? and state LIKE ?',
         "%#{params[:name]}%", "%#{params[:address]}%", "%#{params[:phone_number]}%", "%#{params[:zipcode]}%", "%#{params[:colony]}%", "%#{params[:city]}%", "%#{params[:state]}%").order(name: :desc)
    else
      @clients = Client.all.order(name: :desc)
    end
  end

  def show
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Cliente agregado satisfactoriamente' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Cliente actualizado satisfactoriamente' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, notice: 'El Cliente no pudo ser actualizado' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name, :address, :phone_number, :external_address_num, :internal_address_num, :zipcode, :colony, :city, :state)
    end
end
