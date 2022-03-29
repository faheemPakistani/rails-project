# frozen_string_literal: true

# like controller
class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    authorize @like
    @post = Post.find_by(id: @like.likeable_id) if @like.likeable_type == 'Post'
    @comment = Comment.find_by(id: @like.likeable_id) if @like.likeable_type == 'Comment'
    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save
  end

  def destroy
    @like = current_user.likes.find_by(id: params[:id])
    flash[:message] = @like.errors.full_messages.to_sentence if @like.nil?
    authorize @like
    @like.destroy
    redirect_back(fallback_location: posts_url)
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
