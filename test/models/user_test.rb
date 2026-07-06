require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires name" do
    user = User.new(email: "learner@example.com", password: "password123", name: "")

    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test "uses name as display name" do
    assert_equal "첫번째 사용자", users(:one).display_name
  end
end
