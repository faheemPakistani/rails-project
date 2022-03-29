# frozen_string_literal: true

# suggestion controller
class SuggestionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @suggestion = Suggestion.includes(:user).where(user_id: current_user.id)
    if @suggestion.nil?
      flash[:message] = @suggestion.errors.full_messages.to_sentence
      @suggestion = []
    end
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    flash[:message] = @post.errors.full_messages.to_sentence if @post.nil?
    @suggestion = @post.suggestions.build(suggestion_params)
    @suggestion.user_id = current_user.id
    authorize @suggestion
    flash[:message] = @suggestion.errors.full_messages.to_sentence if @suggestion.body.blank?
    flash[:message] = @suggestion.errors.full_messages.to_sentence unless @suggestion.save!
    redirect_to post_path(@post)
  end

  def new
    @suggestion = Suggestion.new
  end

  def edit
    @suggestion = Suggestion.find_by(id: params[:id])
    flash[:message] = @suggestion.errors.full_messages.to_sentence if @suggestion.nil?
    @post = Post.find(params[:post_id])
    flash[:message] = @post.errors.full_messages.to_sentence if @post.nil?
  end

  def destroy
    @suggestion = Suggestion.find_by(id: params[:id])
    @post = Post.find_by(id: params[:post_id])
    @suggestion.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: 'Suggestion was successfully Rejected.' }
    end
  end

  def update
    @post = Post.find_by(id: params[:post_id])
    flash[:message] = @post.errors.full_messages.to_sentence if @post.nil?
    @suggestion = Suggestion.find_by(id: params[:id])
    @suggestion.update(update_params)
    redirect_to @post
  end

  private

  def update_params
    params.require(:suggestion).permit(:body)
  end

  def suggestion_params
    params.require(:suggestion).permit(:body, :parent_id)
  end
end
