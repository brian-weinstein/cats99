class CatRentalRequestsController < ApplicationController
  before_action :set_cat_rental_request, only: %i[ show edit update destroy approve deny ]
  before_action :require_logged_in!
  before_action :requires_cat_ownership, only: %i(approve deny)

  def approve
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat)
  end

  def deny
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat)
  end
  # GET /cat_rental_requests or /cat_rental_requests.json
  def index
    @cat_rental_requests = CatRentalRequest.all
  end

  # GET /cat_rental_requests/1 or /cat_rental_requests/1.json
  def show
  end

  # GET /cat_rental_requests/new
  def new
    @cat_rental_request = CatRentalRequest.new
  end

  # GET /cat_rental_requests/1/edit
  def edit
  end

  # POST /cat_rental_requests or /cat_rental_requests.json
  def create
    @cat_rental_request = current_user.cat_rental_requests.new(cat_rental_request_params)

    respond_to do |format|
      if @cat_rental_request.save
        format.html { redirect_to cats_url, notice: "Cat rental request was successfully created." }
        format.json { render :show, status: :created, location: @cat_rental_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cat_rental_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cat_rental_requests/1 or /cat_rental_requests/1.json
  def update
    respond_to do |format|
      if @cat_rental_request.update(cat_rental_request_params)
        format.html { redirect_to cat_rental_request_url(@cat_rental_request), notice: "Cat rental request was successfully updated." }
        format.json { render :show, status: :ok, location: @cat_rental_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cat_rental_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cat_rental_requests/1 or /cat_rental_requests/1.json
  def destroy
    @cat_rental_request.destroy

    respond_to do |format|
      format.html { redirect_to cat_rental_requests_url, notice: "Cat rental request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cat_rental_request
      @cat_rental_request = CatRentalRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cat_rental_request_params
      params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
    end

    def requires_cat_ownership
      return if current_user.owns_cat?(@cat_rental_request.cat)
    end
end
