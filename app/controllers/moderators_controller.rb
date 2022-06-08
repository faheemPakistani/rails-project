# frozen_string_literal: true

# post controller
class ModeratorsController < ApplicationController
  def index
    if current_user.role == 'moderator'
      @posts = Post.where(status: 'inactive')
      @reported = Post.joins(:reports)
    else
      respond_to do |format|
        format.html { redirect_to classrooms_path, notice: "Not Eligible, to get access please contact admin@gmail.com" }
      end
    end
  end

  def status
    @post = Post.find_by(id: params[:id])
    flash[:message] = @posts.errors.full_messages.to_sentence if @post.nil?
    if @post.status == 'inactive'
      @post.status = 'active'
    else
      @post.status = 'inactive'
    end
    @post.save!
    redirect_back(fallback_location: posts_url)
  end
end
