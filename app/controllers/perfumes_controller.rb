class PerfumesController < ApplicationController
  before_action :set_perfume, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /perfumes
  # GET /perfumes.json
  def index
    # @perfumes = Perfume.all
    if params[:name]
      @perfumes = Perfume.where('name LIKE ? AND buy_price LIKE ? AND retail_price LIKE ? AND stock LIKE ? AND public_target LIKE ? AND classification LIKE ? AND category LIKE ? AND presentation like ? AND visibility LIKE ?', "%#{params[:name]}%", "%#{params[:buy_price]}", "%#{params[:retail_price]}", "%#{params[:stock]}", "%#{params[:public_target]}%", "%#{params[:classification]}%", "%#{params[:category]}%", "%#{params[:presentation]}%", "%#{params[:visibility]}%")
    else
      @perfumes = Perfume.all
    end
  end

  # GET /perfumes/1
  # GET /perfumes/1.json
  def show
  end

  # GET /perfumes/new
  def new
    @perfume = Perfume.new
  end

  # GET /perfumes/1/edit
  def edit
  end

  # POST /perfumes
  # POST /perfumes.json
  def create
    @perfume = Perfume.new(perfume_params)

    respond_to do |format|
      if @perfume.save
        format.html { redirect_to perfumes_url, notice: 'Perfume agregado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @perfume }
      else
        format.html { render :new }
        format.json { render json: @perfume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perfumes/1
  # PATCH/PUT /perfumes/1.json
  def update
    respond_to do |format|
      if @perfume.update(perfume_params)
        format.html { redirect_to perfumes_url, notice: 'Perfume actualizado satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @perfume }
      else
        format.html { render :edit }
        format.json { render json: @perfume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perfumes/1
  # DELETE /perfumes/1.json
  def destroy
    @perfume.destroy
    respond_to do |format|
      format.html { redirect_to perfumes_url, notice: 'Perfume was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perfume
      @perfume = Perfume.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perfume_params
      params.require(:perfume).permit(:name, :buy_price, :retail_price, :stock, :public_target, :classification, :category, :presentation, :visibility, :picture)
    end
end
