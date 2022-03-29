class SuggestionPolicy < ApplicationPolicy
  attr_reader :current_user, :suggestion

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def initialize(current_user, suggestion)
    super
    @current_user = current_user
    @suggestion = suggestion
  end

  def create?
    true if @current_user
  end
end
