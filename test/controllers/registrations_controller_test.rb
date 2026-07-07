require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "creates user with name" do
    assert_difference("User.count") do
      post user_registration_url, params: {
        user: {
          name: "학습자",
          email: "learner@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_equal "학습자", User.order(:created_at).last.name
  end

  test "does not create user without name" do
    assert_no_difference("User.count") do
      post user_registration_url, params: {
        user: {
          name: "",
          email: "nameless@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_response :unprocessable_content
  end
end
