class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
    # States that you need to be authenticated to access this controller
  before_action :authenticate_user!
  autocomplete :perfume, :name

  def index
    @orders = Order.where(order_datum: params[:order_datum_id])
    @order_datum = OrderDatum.find(params[:order_datum_id])
    @total = 0
  end

  def show
  end

  def new
    @order = Order.new
    @order_datum = OrderDatum.find(params[:order_datum_id])
  end

  def edit
    @order_datum = OrderDatum.find(params[:order_datum_id])
  end

  def create
    @order_datum = OrderDatum.find(params[:order_datum_id])
    @order = Order.new(order_params)
    @perfume = Perfume.where(name: params[:order][:perfume_name]).first

    if !@perfume.blank?
      @order.order_datum_id = @order_datum.id
      @order.perfume_id = @perfume.id
      @order.total = @perfume.retail_price * @order.amount
      respond_to do |format|
        if @order.save
          format.html { redirect_to order_datum_orders_path(@order_datum), notice: 'El articulo fue creado satisfactoriamente' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_order_datum_order_url, notice: 'El artículo ingresado no es válido'}
        format.json { render json: @order_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @order_datum = OrderDatum.where(id: params[:order_datum_id])
    @perfume = Perfume.where(name: params[:order][:perfume_name]).first
    if !@perfume.blank?
      @order.order_datum_id = @order_datum.first.id
      @order.perfume_id = @perfume.id
      @order.total = @perfume.retail_price * @order.amount
      respond_to do |format|
        if @order.update(order_params)
          format.html { redirect_to order_datum_orders_path, notice: 'El articulo fue creado satisfactoriamente' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new, notice: 'El artículo no pudo ser actualizado' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new, notice: 'El artículo ingresado no es válido'}
        format.json { render json: @order_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:amount, :status, :total)
    end
end
