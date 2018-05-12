class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.where(bill_id: params[:bill_id])
    @bill = Bill.where(id: params[:bill_id]).first
    puts params[:bill_id]
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @bill = Bill.where(id: params[:bill_id]).first
  end

  # GET /payments/1/edit
  def edit
    @bill = Bill.where(id: params[:bill_id]).first
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    @payments = Payment.where(bill_id: params[:bill_id])
    @bill = Bill.where(id: params[:bill_id]).first

    @resto = @bill.total
    @payments.each do |pay|
      @resto = @resto - pay.amount
    end

    @resto = @resto - @payment.amount
    @payment.bill_id = @bill.id

    if @resto > 0
      respond_to do |format|
        if @payment.save
          format.html { redirect_to bill_payments_path(@bill), notice: 'Se agregó el abono satisfactoriamente' }
          format.json { render :show, status: :created, location: @payment }
        else
          format.html { render :new }
          format.json { render json: @payment.errors, status: :unprocessable_entity }
        end
      end
    elsif @resto == 0
      respond_to do |format|
        @bill.status = 1
        if @payment.save and @bill.save
          format.html { redirect_to bill_payments_path(@bill), notice: 'Se agregó el abono satisfactoriamente, cuenta saldada' }
          format.json { render :show, status: :created, location: @payment }
        else
          format.html { render :new }
          format.json { render json: @payment.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new, notice: 'El pago es menor al resto de la cuenta' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    @payments = Payment.where(params[:bill_id])
    @bill = Bill.where(params[:bill_id]).first

    if @bill.status = 0
      respond_to do |format|
        if @payment.update(payment_params)
          format.html { redirect_to bill_payments_path(@bill), notice: 'Se agregó el abono satisfactoriamente' }
          format.json { render :show, status: :created, location: @payment }
        else
          format.html { render :new }
          format.json { render json: @payment.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new, notice: 'La cuenta ya se encuentra saldada' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:payment_date, :amount)
    end
end
