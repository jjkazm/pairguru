class CommentPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def destroy?
    return true if user.present? && user == comment.user
  end

  private

    def comment
      record
    end

end
