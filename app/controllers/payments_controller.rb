class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update]
    # States that you need to be authenticated to access this controller
  before_action :authenticate_user!

  def index
    # Gets the Payment with the given Bill
    @payments = Payment.where(bill_id: params[:bill_id])
    @bill = Bill.where(id: params[:bill_id]).first
  end


  def show
  end

  def new
    @payment = Payment.new
    @bill = Bill.where(id: params[:bill_id]).first
  end

  def edit
    @bill = Bill.where(id: params[:bill_id]).first
  end

  def create
    @payment = Payment.new(payment_params)
    @payments = Payment.where(bill_id: params[:bill_id])
    # Gets the bill with the given id
    @bill = Bill.where(id: params[:bill_id]).first

    # Substracts every bill from the total
    @resto = @bill.total
    @payments.each do |pay|
      @resto = @resto - pay.amount
    end
    # Substracts the new bill from the total and sets the relationship
    @resto = @resto - @payment.amount
    @payment.bill_id = @bill.id

    # If the remainder is equal to 0, it prints that the payment is finished
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
          format.html { render :new, 'El pago no pudo ser agregado' }
          format.json { render json: @payment.errors, status: :unprocessable_entity }
        end
      end
    # If the remainder is negative, sends an error
    else
      respond_to do |format|
        format.html { render :new, notice: 'El pago es menor al resto de la cuenta' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @payments = Payment.where(params[:bill_id])
    # Gets the payment witht he given id
    @bill = Bill.where(params[:bill_id]).first

    # If the bill's status is finished, it throws an error
    # else, it saves the payment
    if @bill.status = 0
      respond_to do |format|
        if @payment.update(payment_params)
          format.html { redirect_to bill_payments_path(@bill), notice: 'Se agregó el abono satisfactoriamente' }
          format.json { render :show, status: :created, location: @payment }
        else
          format.html { render :new, notice: 'El abono no pudo ser agregado' }
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

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:payment_date, :amount)
    end
end
