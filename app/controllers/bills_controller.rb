class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]
  autocomplete :client, :name
  autocomplete :perfume, :name

  # GET /bill
  # GET /bill.json
  def index
    @bills = Bill.all.order(bill_date: :desc)
  end

  # GET /bill/1
  # GET /bill/1.json
  def show
    @payments = Payment.where(bill_id: params[:id])
    @resto = @bill.total
  end

  # GET /bill/new
  def new
    @bill = Bill.new
  end

  # GET /bill/1/edit
  def edit
  end

  # POST /bill
  # POST /bill.json
  def create
    @client = Client.where(name: params[:bill][:client_name]).first
    @perfume = Perfume.where(name: params[:bill][:perfume_name], classification: params[:bill][:perfume_classification]).first
    @bill = Bill.new(bill_params)

    if !@client.blank? and !@perfume.blank?
      if (@perfume.stock - params[:bill][:amount].to_i) >= 0
        @bill.client_id = @client.id
        @bill.perfume_id = @perfume.id
        @bill.total = @perfume.buy_price * @bill.amount
        @bill.status = 0
        @perfume.stock = @perfume.stock - params[:bill][:amount].to_i
        respond_to do |format|
          if @bill.save and @perfume.save
            format.html { redirect_to @bill, notice: 'La cuenta se creó satisfactoriamente. Se actualizó el stock' }
            format.json { render :show, status: :created, location: @bill }
          else
            format.html { redirect_to new_bill_url, notice: 'La cuenta no pudo ser guardada en la base de datos' }
            format.json { render json: @bill.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to new_bill_url, notice: 'Se intentó vender mas perfumes de los que hay en stock' }
          format.json { render json: @bill.errors, status: :unprocessable_entity }
        end
      end

    else
      respond_to do |format|
        format.html { redirect_to new_bill_url, notice: 'El cliente o el perfume ingresado no es válido'}
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bill/1
  # PATCH/PUT /bill/1.json
  def update
    @client = Client.where(name: params[:bill][:client_name]).first
    @perfume = Perfume.where(name: params[:bill][:perfume_name], classification: params[:bill][:perfume_classification]).first

    if !@client.blank? and !@perfume.blank?
      if (@perfume.stock - params[:bill][:amount].to_i) >= 0
        @bill.client_id = @client.id
        @bill.perfume_id = @perfume.id
        @bill.total = @perfume.buy_price * @bill.amount
        @bill.status = 0
        @perfume.stock = @perfume.stock - params[:bill][:amount].to_i
        respond_to do |format|
          if @bill.update(bill_params) and @perfume.save
            format.html { redirect_to @bill, notice: 'La cuenta se creó satisfactoriamente. Se actualizó el stock' }
            format.json { render :show, status: :created, location: @bill }
          else
            format.html { render :new, notice: 'La cuenta no pudo ser guardada en la base de datos' }
            format.json { render json: @bill.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { render :new, notice: 'Se intento vender mas perfumes de los que hay en stock' }
          format.json { render json: @bill.errors, status: :unprocessable_entity }
        end
      end

    else
      respond_to do |format|
        format.html { render :new, notice: 'El cliente o el perfume ingresado no es válido'}
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bill/1
  # DELETE /bill/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to order_data_url, notice: 'Order datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
  def set_bill
      @bill = Bill.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bill_params
    params.require(:bill).permit(:bill_date, :amount)
  end
end
