class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[ show edit update destroy ]

  # GET /submissions or /submissions.json
  def index
    @submissions = Submission.where(classwork_id: params[:classwork_id]).order(id: :desc)
  end

  # GET /submissions/1 or /submissions/1.json
  def show
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions or /submissions.json
  def create
    @classwork = Classwork.find(params[:submission][:classwork_id])
    flash[:message] = @classwork.errors.full_messages.to_sentence if @classwork.nil?
    # byebug
    if @classwork.expiry > (Time.zone.now + 5.hours)
      format.html { redirect_to classwork_url(@classwork), notice: "This Assignment has been expired" }
    else
      @submission = @classwork.submissions.create(submission_params.merge(user_id: current_user.id))
      respond_to do |format|
        if @submission.save
          format.html { redirect_to classrooms_path, notice: "Submission was successfully created." }
          format.json { render :show, status: :created, location: @submission }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @submission.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PATCH/PUT /submissions/1 or /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to submission_url(@submission), notice: "Submission was successfully updated." }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1 or /submissions/1.json
  def destroy
    @submission.destroy

    respond_to do |format|
      format.html { redirect_to submissions_url, notice: "Submission was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:solution, :classwork_id, :classroom_id)
    end
end
