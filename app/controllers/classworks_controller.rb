class ClassworksController < ApplicationController
  before_action :set_classwork, only: %i[ show edit update destroy ]

  # GET /classworks or /classworks.json
  def index
    @classworks = Classwork.all
  end

  # GET /classworks/1 or /classworks/1.json
  def show
  end

  # GET /classworks/new
  def new
    @classwork = Classwork.new
  end

  # GET /classworks/1/edit
  def edit
  end

  # POST /classworks or /classworks.json
  def create
    @classroom = Classroom.find(params[:classroom_id])
    flash[:message] = @classroom.errors.full_messages.to_sentence if @classroom.nil?
    @classwork = @classroom.classworks.create(classwork_params.merge(user_id: current_user.id))
    if @classwork.body.blank?
      flash[:message] = @classwork.errors.full_messages.to_sentence
    else
      flash[:message] = @classwork.errors.full_messages.to_sentence unless @classwork.save
    end
    redirect_to classroom_path(@classroom)
  end

  # PATCH/PUT /classworks/1 or /classworks/1.json
  def update
    respond_to do |format|
      if @classwork.update(classwork_params)
        format.html { redirect_to classwork_url(@classwork), notice: "Classwork was successfully updated." }
        format.json { render :show, status: :ok, location: @classwork }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @classwork.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classworks/1 or /classworks/1.json
  def destroy
    @classwork.destroy

    respond_to do |format|
      format.html { redirect_to classworks_url, notice: "Classwork was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classwork
      @classwork = Classwork.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def classwork_params
      params.require(:classwork).permit(:body, :parent_id, :work_type)
    end
end
