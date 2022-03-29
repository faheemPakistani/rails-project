# frozen_string_literal: true

# comments controller
class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    flash[:message] = @post.errors.full_messages.to_sentence if @post.nil?
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    authorize @comment
    if @comment.body.blank?
      flash[:message] = @comment.errors.full_messages.to_sentence
    else
      flash[:message] = @comment.errors.full_messages.to_sentence unless @comment.save
    end
    redirect_to post_path(@post)
  end

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    authorize @comment
    flash[:message] = @comment.errors.full_messages.to_sentence if @comment.nil?
    @post = Post.find_by(id: params[:post_id])
    flash[:message] = @post.errors.full_messages.to_sentence if @post.nil?
  end

  def update
    @post = Post.find_by(id: params[:post_id])
    flash[:message] = @post.errors.full_messages.to_sentence if @post.nil?
    @comment = Comment.find_by(id: params[:id])
    flash[:message] = @post.errors.full_messages.to_sentence if @comment.nil?
    authorize @comment
    @comment.update(update_params)
    redirect_to @post
  end

  private

  def update_params
    params.require(:comment).permit(:body)
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
