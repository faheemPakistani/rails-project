class ClassroomsController < ApplicationController
  before_action :set_classroom, only: %i[ show edit update destroy ]

  # GET /classrooms or /classrooms.json
  def index
    if current_user.user_type == 'teacher'
      @classrooms = Classroom.where(user_id: current_user.id) || []
    else
      @joined_classes = Userclass.where(user_id: current_user.id) || []
      @classrooms = Classroom.find(@joined_classes.to_ary.map { |string| string.classroom_id })
    end
  end

  # GET /classrooms/1 or /classrooms/1.json
  def show
    @classroom = Classroom.find_by(id: params[:id])
    @classwork = Classwork.where(classroom_id: @classroom.id)
    @people = Userclass.where(classroom_id: @classroom.id) || []
    @users = User.find(@people.to_ary.map { |string| string.classroom_id })
    @teacher = User.find_by(id: @classroom.user_id) || ''
    if @classroom.nil?
      flash[:message] = @classroom.errors.full_messages.to_sentence
    end
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new(params[:classroom])
  end

  # GET /classrooms/1/edit
  def edit
  end

  # POST /classrooms or /classrooms.json
  def create
    @classroom = Classroom.new(classroom_params)
    @classroom.user_id = current_user.id
    @code = ([*('A'..'Z'),*('a'..'z'),*('0'..'9')]-%w(0 1 I O)).sample(7).join
    @classroom.class_code = @code
    respond_to do |format|
      if @classroom.save
        format.html { redirect_to classroom_url(@classroom), notice: "Classroom was successfully created." }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classrooms/1 or /classrooms/1.json
  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to classroom_url(@classroom), notice: "Classroom was successfully updated." }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classrooms/1 or /classrooms/1.json
  def destroy
    @classroom.destroy

    respond_to do |format|
      format.html { redirect_to classrooms_url, notice: "Classroom was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def classroom_params
      params.require(:classroom).permit(:title, :description, :avatar)
    end
end
