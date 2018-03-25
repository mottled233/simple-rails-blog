require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Some One", email: "Foo@bar.com")
  end
  
  def recover
    @user.name = "Some One"
    @user.email = "Foo@bar.com"
  end
  
  test "should be vaild" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name="   "
    assert_not @user.valid?
    recover
  end
  
  test "email should be present" do
    @user.email="  "
    assert_not @user.valid?
    recover
  end
  
  test "name should not be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
    recover
  end
  
  test "email should not be too long" do
    @user.email = "a"*254+"@bar.com"
    assert_not @user.valid?
    recover
  end
  
end
