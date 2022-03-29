class CommentPolicy < ApplicationPolicy
  attr_reader :current_user, :comment

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def initialize(current_user, comment)
    super
    @current_user = current_user
    @comment = comment
  end

  def create?
    true if @current_user
  end

  def edit?
    true if @comment.user_id == @current_user.id
  end

  def update?
    true if @comment.user_id == @current_user.id
  end
end
