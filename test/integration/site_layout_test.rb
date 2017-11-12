require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "layout links" do
    get root_path
      assert_template 'static_pages/home'
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
        get help_path
        assert_select "title", full_title("Help")
      assert_select "a[href=?]", about_path
        get about_path
        assert_select "title", full_title("About")
      assert_select "a[href=?]", contact_path
        get contact_path
        assert_select "title", full_title("Contact")
      assert_select "a[href=?]", login_path
        get login_path
        assert_select "title", full_title("Log in")
      user = users(:michael)
      log_in_as(user)
      get root_path
        assert_select "a[href=?]", logout_path
        assert_select "a[href=?]", users_path
          get users_path
          assert_select "title", full_title("All users")
        assert_select "a[href=?]", user_path(user)
          get user_path(user)
          assert_select "title", full_title(user.name)
        assert_select "a[href=?]", edit_user_path(user)
          get edit_user_path(user)
          assert_select "title", full_title("Edit user")
  end
end