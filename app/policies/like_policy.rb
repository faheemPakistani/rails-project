class LikePolicy < ApplicationPolicy
  attr_reader :current_user, :like

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def initialize(current_user, like)
    super
    @current_user = current_user
    @like = like
  end

  def create?
    true if @current_user
  end

  def destroy?
    true if @like.user_id == @current_user.id
  end
end
