require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @group = groups(:one)
  end

  test "should get index" do
    get groups_url
    assert_response :success
    assert_select "h1", "그룹 관리"
  end

  test "should get show" do
    get group_url(@group)
    assert_response :success
    assert_select "h1", @group.name
  end

  test "should get new" do
    get new_group_url
    assert_response :success
    assert_select "h1", "새 그룹 만들기"
  end

  test "should create group" do
    assert_difference("Group.count") do
      post groups_url, params: { group: { name: "문학 표현", description: "책에서 만난 문장" } }
    end

    assert_redirected_to groups_url
  end

  test "should get edit" do
    get edit_group_url(@group)
    assert_response :success
    assert_select "h1", "그룹 수정"
  end

  test "should update group" do
    patch group_url(@group), params: { group: { name: "Updated Group", description: @group.description } }
    assert_redirected_to groups_url
  end

  test "should destroy group" do
    assert_difference("Group.count", -1) do
      delete group_url(@group)
    end

    assert_redirected_to groups_url
  end
end
