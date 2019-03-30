### Fun with Mutators Pattern.

Don't use before_* callbacks in rails magic, instead use mutators patterns.

#### Before
```rb
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

class UsersController
  def destroy
    # ..
    @user.destroy!
    # ..
  end
end
```

#### After
```rb
class User < ApplicationRecord
  scope :highest_grade_users, ->(user) { where('grade > ?', user.grade) }

  def grade_decrease!
    self.grade -= 1
    save!
  end
end

class UserMutator
  def self.destroy!(user)
    highest_grade_users = User.highest_grade_users(user)
    highest_grade_users.each(&:grade_decrease!)
    user.destroy!
  end
end

class UsersController
  def destroy!
    # ..
    UserMutator.destroy!(@user)
    # ..
  end
end
```
