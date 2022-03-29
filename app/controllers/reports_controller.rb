# frozen_string_literal: true

# report controller
class ReportsController < ApplicationController
  def create
    @report = current_user.reports.new(report_params)
    authorize @report
    @post = Post.find_by(id: @report.reportable_id) if @report.reportable_type == 'Post'
    @comment = Comment.find_by(id: @report.reportable_id) if @report.reportable_type == 'Comment'
    flash[:notice] = @report.errors.full_messages.to_sentence unless @report.save
    # redirect_back(fallback_location: posts_url)
  end

  def destroy
    @report = current_user.reports.find_by(id: params[:id])
    flash[:notice] = @report.errors.full_messages.to_sentence if @report.nil?
    authorize @report
    @report.destroy
    redirect_back(fallback_location: posts_url)
  end

  private

  def report_params
    params.require(:report).permit(:reportable_id, :reportable_type)
  end
end
