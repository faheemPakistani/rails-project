class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: %i[ show edit update destroy ]

  # GET /announcements or /announcements.json

  # GET /announcements/1 or /announcements/1.json

  # GET /announcements/new
  def new
    @announcement = Announcement.new
  end

  # GET /announcements/1/edit
  def edit
  end

  # POST /announcements or /announcements.json
  def create
    @classroom = Classroom.find(params[:classroom_id])
    flash[:message] = @classroom.errors.full_messages.to_sentence if @classroom.nil?
    @announcement = @classroom.announcements.create(announcement_params.merge(user_id: current_user.id))
    if @announcement.body.blank?
      flash[:message] = @announcement.errors.full_messages.to_sentence
    else
      flash[:message] = @announcement.errors.full_messages.to_sentence unless @announcement.save
    end
    redirect_to classroom_path(@classroom)
  end

  # PATCH/PUT /announcements/1 or /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to announcement_url(@announcement), notice: "Announcement was successfully updated." }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1 or /announcements/1.json
  def destroy
    @announcement.destroy

    respond_to do |format|
      format.html { redirect_to announcements_url, notice: "Announcement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def announcement_params
      params.require(:announcement).permit(:body, :parent_id, :status)
    end
end
