require "test_helper"

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:one)
    @member = users(:two)
  end

  test "admin can access user list" do
    sign_in @admin

    get admin_users_url

    assert_response :success
    assert_select "h1", "사용자 관리"
    assert_select "td", /user1@example.com/
  end

  test "non-admin cannot access user list" do
    sign_in @member

    get admin_users_url

    assert_redirected_to root_url
    assert_equal "관리자만 접근할 수 있습니다.", flash[:alert]
  end

  test "unauthenticated user is redirected to sign in" do
    get admin_users_url

    assert_redirected_to new_user_session_url
  end

  test "admin can promote a member to admin" do
    sign_in @admin

    patch admin_user_url(@member), params: { is_admin: true }

    assert_redirected_to admin_users_url
    assert_equal "관리자 권한을 부여했습니다.", flash[:notice]
    assert @member.reload.is_admin?
  end

  test "admin cannot demote self" do
    sign_in @admin

    patch admin_user_url(@admin), params: { is_admin: false }

    assert_redirected_to admin_users_url
    assert_equal "자기 자신의 관리자 권한은 해제할 수 없습니다.", flash[:alert]
    assert @admin.reload.is_admin?
  end

  test "admin can demote another admin when at least one admin remains" do
    @member.update!(is_admin: true)
    sign_in @admin

    patch admin_user_url(@member), params: { is_admin: false }

    assert_redirected_to admin_users_url
    assert_equal "관리자 권한을 해제했습니다.", flash[:notice]
    assert_not @member.reload.is_admin?
  end

  test "non-admin cannot update admin state" do
    sign_in @member

    patch admin_user_url(@admin), params: { is_admin: false }

    assert_redirected_to root_url
    assert_equal "관리자만 접근할 수 있습니다.", flash[:alert]
    assert @admin.reload.is_admin?
  end
end
