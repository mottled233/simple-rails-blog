require '/home/ubuntu/workspace/sample_app/test/test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Home #{@head_string}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help #{@head_string}"
  end
  
  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About #{@head_string}"
  end
  
  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact #{@head_string}"
  end
    
  def setup
    @head_string = "| Sample App use Ruby on Rails"
  end
  
  test "should get root" do
    get root_url
    assert_response :success
    assert_select "title", "Home #{@head_string}"
  end
end
