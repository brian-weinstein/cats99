class CatsController < ApplicationController
  before_action :require_logged_in!, only: %i(new create edit update)

  # GET /cats or /cats.json
  def index
    @cats = Cat.all
    render :index
  end

  # GET /cats/1 or /cats/1.json
  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  # GET /cats/new
  def new
    @cat = Cat.new
    render :new
  end

  # GET /cats/1/edit
  def edit
    @cat = current_user.cats.find(params[:id])
    render :edit
  end

  # POST /cats or /cats.json
  def create
    @cat = current_user.cats.new(cat_params)

    respond_to do |format|
      if @cat.save
        format.html { redirect_to cat_url(@cat), notice: "Cat was successfully created." }
        format.json { render :show, status: :created, location: @cat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cats/1 or /cats/1.json
  def update

    respond_to do |format|
      if @cat.update(cat_params)
        format.html { redirect_to cat_url(@cat), notice: "Cat was successfully updated." }
        format.json { render :show, status: :ok, location: @cat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cats/1 or /cats/1.json
  def destroy
    @cat.destroy

    respond_to do |format|
      format.html { redirect_to cats_url, notice: "Cat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    
    # Only allow a list of trusted parameters through.
    def cat_params
      params.require(:cat).permit(:name, :birth_date, :color, :sex, :description)
    end
end
