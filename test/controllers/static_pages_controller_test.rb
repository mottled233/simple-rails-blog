require '/home/ubuntu/workspace/sample_app/test/test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get home_path
    assert_response :success
    assert_select "title", "Home #{@head_string}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help #{@head_string}"
  end
  
  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About #{@head_string}"
  end
  
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact #{@head_string}"
  end
    
  def setup
    @head_string = "| Sample Blog use Ruby on Rails"
  end
  
  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", "Home #{@head_string}"
  end
end
