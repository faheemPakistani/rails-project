# frozen_string_literal: true

# post controller
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    if params[:user_id].nil?
      @posts = Post.where(status: 'active').order(id: :desc)
    else
      @posts = Post.includes(:user).where(user_id: current_user.id).order(id: :desc)
    end
    if @posts.nil?
      flash[:message] = @posts.errors.full_messages.to_sentence
      @posts = []
    end
    authorize @posts
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      flash[:message] = @post.errors.full_messages.to_sentence
    else
      @suggestion = @post.suggestions.build
    end
  end

  def new
    @post = Post.new(params[:post])
  end

  def edit
    @post = Post.find_by(id: params[:id])
    authorize @post
    flash[:message] = @post.errors.full_messages.to_sentence if @post.nil?
  end

  def create
    @post = Post.new(post_params)
    authorize @post
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    flash[:message] = @post.errors.full_messages.to_sentence if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
