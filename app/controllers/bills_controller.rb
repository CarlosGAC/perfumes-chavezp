class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  autocomplete :client, :name
  autocomplete :perfume, :name

  # GET /bill
  # GET /bill.json
  def index
    if params[:client_name] or params[:perfume_name] or params[:status]
      @bills = Bill.joins(:client).joins(:perfume).where('clients.name LIKE ? AND perfumes.name LIKE ? AND status LIKE ?', "%#{params[:client_name]}%", "%#{params[:perfume_name]}%", "%#{params[:status]}")
    else
      @bills = Bill.all.order(bill_date: :desc)
    end
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
    @old_perfume = Perfume.where(id: @bill.perfume_id)
    puts @old_perfume 
    if !@client.blank? and !@perfume.blank?
      if (@perfume.stock - params[:bill][:amount].to_i) >= 0
        @bill.client_id = @client.id
        @bill.perfume_id = @perfume.id
        @bill.total = @perfume.buy_price * @bill.amount
        @bill.status = 0
        
        if(@perfume.id != @old_perfume.first.id)
          @old_perfume.first.stock = @old_perfume.first.stock + @bill.amount
          @perfume.stock = @perfume.stock - params[:bill][:amount].to_i
          @old_perfume.first.save
        else
          new_amount = params[:bill][:amount].to_i
          if @bill.amount > new_amount
            @perfume.stock = @perfume.stock + (@bill.amount - new_amount)
          elsif @bill.amount < new_amount
            @perfume.stock = @perfume.stock - (new_amount - @bill.amount)
          end
        end
        
        respond_to do |format|
          if @bill.update(bill_params) and @perfume.save
            format.html { redirect_to @bill, notice: 'La cuenta se actualizó satisfactoriamente. Se actualizó el stock' }
            format.json { render :show, status: :created, location: @bill }
          else
            format.html { render :new, notice: 'La cuenta no pudo ser guardada en la base de datos' }
            format.json { render json: @bill.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { render :edit, notice: 'Se intento vender mas perfumes de los que hay en stock' }
          format.json { render json: @bill.errors, status: :unprocessable_entity }
        end
      end

    else
      respond_to do |format|
        format.html { render :edit, notice: 'El cliente o el perfume ingresado no es válido'}
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
