# frozen_string_literal: true

# Report policy
class ReportPolicy < ApplicationPolicy
  attr_reader :current_user, :report

  # scope
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def initialize(current_user, report)
    super
    @current_user = current_user
    @report = report
  end

  def create?
    true if @current_user
  end

  def destroy?
    true if @report.user_id == @current_user.id
  end
end
