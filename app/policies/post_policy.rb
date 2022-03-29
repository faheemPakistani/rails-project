class PostPolicy < ApplicationPolicy
  attr_reader :current_user, :post

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def initialize(current_user, post)
    super
    @current_user = current_user
    @post = post
  end

  def index?
    true
  end

  def update?
    true if @post.user_id == @current_user.id
  end

  def create?
    true if @current_user
  end

  def edit?
    true if @post.user_id == @current_user.id
  end

  def destroy?
    true if @post.user_id == @current_user.id
  end
end
