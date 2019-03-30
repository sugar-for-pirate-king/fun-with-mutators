class UserMutator
  def self.destroy!(user)
    highest_grade_users = User.highest_grade_users(user)
    highest_grade_users.each(&:grade_decrease!)
    user.destroy!
  end
end