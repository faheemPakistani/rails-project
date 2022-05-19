class UserclassesController < ApplicationController
  before_action :set_userclass, only: %i[ show edit update destroy ]

  # GET /userclasses or /userclasses.json
  def index
    @userclasses = Userclass.all
  end

  # GET /userclasses/1 or /userclasses/1.json
  def show
  end

  # GET /userclasses/new
  def new
    @userclass = Userclass.new
  end

  # GET /userclasses/1/edit
  def edit
  end

  # POST /userclasses or /userclasses.json
  def create
    @code = userclass_params.to_h.values[0]
    @isClassExist = Classroom.where(class_code: @code)
    respond_to do |format|
      if !@isClassExist.empty?
        @isAlreadyEnrolled = Userclass.where(classroom_id: @isClassExist[0].id, user_id: current_user.id)
        if !@isAlreadyEnrolled.empty?
          format.html { redirect_to classrooms_path, notice: "Already enrolled in this class" }
        else
          Userclass.create(user_id: current_user.id, classroom_id: @isClassExist[0].id)
          format.html { redirect_to classrooms_path, notice: "Enrolled Successfully" }
        end
      else
        format.html { redirect_to classrooms_path, notice: "Classroom does not exist" }
      end
    end
  end

  # PATCH/PUT /userclasses/1 or /userclasses/1.json
  def update
    respond_to do |format|
      if @userclass.update(userclass_params)
        format.html { redirect_to userclass_url(@userclass), notice: "Userclass was successfully updated." }
        format.json { render :show, status: :ok, location: @userclass }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @userclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userclasses/1 or /userclasses/1.json
  def destroy
    @userclass.destroy

    respond_to do |format|
      format.html { redirect_to userclasses_url, notice: "Userclass was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userclass
      @userclass = Userclass.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def userclass_params
      params.require(:userclass).permit(:class_code)
    end
end
