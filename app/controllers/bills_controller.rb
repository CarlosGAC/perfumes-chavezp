class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update]
  # States that you need to be authenticated to access this controller
  before_action :authenticate_user!
  
  # Creates the autocomplete controller methods for the names
  autocomplete :client, :name
  autocomplete :perfume, :name

  def index
    if params[:client_name] or params[:perfume_name] or params[:status]
      @bills = Bill.joins(:client).joins(:perfume).where('clients.name LIKE ? AND perfumes.name LIKE ? AND status LIKE ?', "%#{params[:client_name]}%", "%#{params[:perfume_name]}%", "%#{params[:status]}")
    else
      @bills = Bill.all.order(bill_date: :desc)
    end
  end

  def show
    # Payments with the given bill id
    @payments = Payment.where(bill_id: params[:id])
    @resto = @bill.total
  end

  def new
    @bill = Bill.new
  end

  def edit
  end

  def create
    # Client with the given name
    @client = Client.where(name: params[:bill][:client_name]).first
    # Perfume with the given name
    @perfume = Perfume.where(name: params[:bill][:perfume_name], classification: params[:bill][:perfume_classification]).first
    @bill = Bill.new(bill_params)
    
    # If both client and perfume with the given names exist
    if !@client.blank? and !@perfume.blank?
      # If the perfume's stock is greater then the bill amount
      if (@perfume.stock - params[:bill][:amount].to_i) >= 0
        # Store relationship id's
        @bill.client_id = @client.id
        @bill.perfume_id = @perfume.id
        # Calculates the total
        @bill.total = @perfume.buy_price * @bill.amount
        # Puts status to "pending"
        @bill.status = 0
        # Updates stock
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
      # If the bill amount is greater than the stock
      else
        respond_to do |format|
          format.html { redirect_to new_bill_url, notice: 'Se intentó vender mas perfumes de los que hay en stock' }
          format.json { render json: @bill.errors, status: :unprocessable_entity }
        end
      end
    # If client or perfumes doesn't exist
    else
      respond_to do |format|
        format.html { redirect_to new_bill_url, notice: 'El cliente o el perfume ingresado no es válido'}
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # Client and Perfume with the given name and classification
    @client = Client.where(name: params[:bill][:client_name]).first
    @perfume = Perfume.where(name: params[:bill][:perfume_name], classification: params[:bill][:perfume_classification]).first
    # Gets the perfume that was stored before editing
    @old_perfume = Perfume.where(id: @bill.perfume_id).first
    # If Client and Perfume exist
    if !@client.blank? and !@perfume.blank?
      if (@perfume.stock - params[:bill][:amount].to_i) >= 0
        # Updates relationships
        @bill.client_id = @client.id
        @bill.perfume_id = @perfume.id
        # Calculates total
        @bill.total = @perfume.buy_price * @bill.amount
        # Puts status to pending
        @bill.status = 0
        # If the old perfume is not the same as the new one
        if(@perfume.id != @old_perfume.id)
          # Updates the old perfume's stock, 
          # adding the amount that was taken away
          @old_perfume.stock = @old_perfume.stock + @bill.amount
          # Updates the new perfume's stock
          # substracting the amount
          @perfume.stock = @perfume.stock - params[:bill][:amount].to_i
          # Saves the old perfume
          @old_perfume.save
        else
          new_amount = params[:bill][:amount].to_i
          # If the new amount is greater than the old one
          if @bill.amount > new_amount
            @perfume.stock = @perfume.stock + (@bill.amount - new_amount)
          # If the new amount is lesser than the old one
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

  private

  def set_bill
      @bill = Bill.find(params[:id])
  end

  def bill_params
    params.require(:bill).permit(:bill_date, :amount)
  end
end
