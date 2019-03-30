class User < ApplicationRecord
  before_destroy :increase_grades_of_highest_users

  scope :highest_grade_users, ->(user) { where('grade > ?', user.grade) }

  def grade_decrease!
    self.grade -= 1
    save!
  end

  private

  def increase_grades_of_highest_users
    User.highest_grade_users(self).each(&:grade_decrease!)
  end
end
