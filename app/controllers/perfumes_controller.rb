class PerfumesController < ApplicationController
  before_action :set_perfume, only: [:show, :edit, :update]
    # States that you need to be authenticated to access this controller
  before_action :authenticate_user!
  
  def index
    if params[:name] or params[:buy_price] or params[:retail_price] or params[:stock]
      if params[:stock].blank?
        if params[:buy_price].blank?
          if params[:retail_price].blank?
            @perfumes = Perfume.where('name LIKE ? AND buy_price LIKE ? AND retail_price LIKE ? AND stock LIKE ? AND public_target LIKE ? AND classification LIKE ? AND category LIKE ? AND presentation like ? AND visibility LIKE ?', "%#{params[:name]}%", "%#{params[:buy_price]}%", "%#{params[:retail_price]}%", "%#{params[:stock]}%", "%#{params[:public_target]}%", "%#{params[:classification]}%", "%#{params[:category]}%", "%#{params[:presentation]}%", "%#{params[:visibility]}%")
          else
            @perfumes = Perfume.where('name LIKE ? AND buy_price LIKE ? AND retail_price LIKE ? AND stock LIKE ? AND public_target LIKE ? AND classification LIKE ? AND category LIKE ? AND presentation like ? AND visibility LIKE ?', "%#{params[:name]}%", "%#{params[:buy_price]}%", "#{params[:retail_price]}", "%#{params[:stock]}%", "%#{params[:public_target]}%", "%#{params[:classification]}%", "%#{params[:category]}%", "%#{params[:presentation]}%", "%#{params[:visibility]}%")
          end
        else
          if !params[:retail_price].blank?
            @perfumes = Perfume.where('name LIKE ? AND buy_price LIKE ? AND retail_price LIKE ? AND stock LIKE ? AND public_target LIKE ? AND classification LIKE ? AND category LIKE ? AND presentation like ? AND visibility LIKE ?', "%#{params[:name]}%", "#{params[:buy_price]}", "%#{params[:retail_price]}%", "%#{params[:stock]}%", "%#{params[:public_target]}%", "%#{params[:classification]}%", "%#{params[:category]}%", "%#{params[:presentation]}%", "%#{params[:visibility]}%")
          else
            @perfumes = Perfume.where('name LIKE ? AND buy_price LIKE ? AND retail_price LIKE ? AND stock LIKE ? AND public_target LIKE ? AND classification LIKE ? AND category LIKE ? AND presentation like ? AND visibility LIKE ?', "%#{params[:name]}%", "#{params[:buy_price]}", "#{params[:retail_price]}", "%#{params[:stock]}%", "%#{params[:public_target]}%", "%#{params[:classification]}%", "%#{params[:category]}%", "%#{params[:presentation]}%", "%#{params[:visibility]}%")
          end
        end
      else
        if params[:buy_price].blank?
          if params[:retail_price].blank?
            @perfumes = Perfume.where('name LIKE ? AND buy_price LIKE ? AND retail_price LIKE ? AND stock LIKE ? AND public_target LIKE ? AND classification LIKE ? AND category LIKE ? AND presentation like ? AND visibility LIKE ?', "%#{params[:name]}%", "%#{params[:buy_price]}%", "%#{params[:retail_price]}%", "#{params[:stock]}", "%#{params[:public_target]}%", "%#{params[:classification]}%", "%#{params[:category]}%", "%#{params[:presentation]}%", "%#{params[:visibility]}%")
          else
            @perfumes = Perfume.where('name LIKE ? AND buy_price LIKE ? AND retail_price LIKE ? AND stock LIKE ? AND public_target LIKE ? AND classification LIKE ? AND category LIKE ? AND presentation like ? AND visibility LIKE ?', "%#{params[:name]}%", "%#{params[:buy_price]}%", "#{params[:retail_price]}", "#{params[:stock]}", "%#{params[:public_target]}%", "%#{params[:classification]}%", "%#{params[:category]}%", "%#{params[:presentation]}%", "%#{params[:visibility]}%")
          end
        else
          if params[:retail_price].blank?
            @perfumes = Perfume.where('name LIKE ? AND buy_price LIKE ? AND retail_price LIKE ? AND stock LIKE ? AND public_target LIKE ? AND classification LIKE ? AND category LIKE ? AND presentation like ? AND visibility LIKE ?', "%#{params[:name]}%", "#{params[:buy_price]}", "%#{params[:retail_price]}%", "#{params[:stock]}", "%#{params[:public_target]}%", "%#{params[:classification]}%", "%#{params[:category]}%", "%#{params[:presentation]}%", "%#{params[:visibility]}%")
          else
            @perfumes = Perfume.where('name LIKE ? AND buy_price LIKE ? AND retail_price LIKE ? AND stock LIKE ? AND public_target LIKE ? AND classification LIKE ? AND category LIKE ? AND presentation like ? AND visibility LIKE ?', "%#{params[:name]}%", "#{params[:buy_price]}", "#{params[:retail_price]}", "#{params[:stock]}", "%#{params[:public_target]}%", "%#{params[:classification]}%", "%#{params[:category]}%", "%#{params[:presentation]}%", "%#{params[:visibility]}%")
          end
        end
      end
    else
      @perfumes = Perfume.all
    end
  end

  def show
  end

  def new
    @perfume = Perfume.new
  end

  def edit
  end

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

  def destroy
    @perfume.destroy
    respond_to do |format|
      format.html { redirect_to perfumes_url, notice: 'Perfume was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_perfume
      @perfume = Perfume.find(params[:id])
    end

    def perfume_params
      params.require(:perfume).permit(:name, :buy_price, :retail_price, :stock, :public_target, :classification, :category, :presentation, :visibility, :picture)
    end
end
