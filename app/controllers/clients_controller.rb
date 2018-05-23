class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  autocomplete :postal_code, :c_postal, additional_data: [:settlement, :township, :state, :city]
  # GET /clients
  # GET /clients.json
  def index
    if params[:name] or params[:address] or params[:phone_number] or params[:external_address_num] or params[:zipcode] or params[:colony] or params[:city] or params[:state]
      @clients = Client.where('name LIKE ? AND address LIKE ? AND phone_number LIKE ? AND zipcode LIKE ? AND colony LIKE ? AND city LIKE ? and state LIKE ?',
         "%#{params[:name]}%", "%#{params[:address]}%", "%#{params[:phone_number]}%", "%#{params[:zipcode]}%", "%#{params[:colony]}%", "%#{params[:city]}%", "%#{params[:state]}%").order(name: :desc)
    else
      @clients = Client.all.order(name: :desc)
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients.json
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

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Cliente actualizado satisfactoriamente' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :address, :phone_number, :external_address_num, :internal_address_num, :zipcode, :colony, :city, :state)
    end
end
