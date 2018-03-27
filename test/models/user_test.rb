require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Some One", email: "631061840@qq.com", password: "foobar", password_confirmation: "foobar")
  end
  
  def recover
    @user.name = "Some One"
    @user.email = "Foo@bar.com"
    @user.password = "foobar"
    @user.password_confirmation = "foobar"
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
  
  
  test "invalid email should be reject" do
    invalid_email = %w[user@example,com user_at_foo.org foo@bar_baz.com foo@bar+baz.com]
    invalid_email.each do |invalid|
      @user.email = invalid
      assert_not @user.valid?, "#{invalid} not pass"
    end
    recover
  end
  
  test "email should be unique" do
    @user.save
    dup = @user.dup
    assert_not dup.save
    dup.email.upcase!
    assert_not dup.save
  end
  
  test "valid email should be valid" do
    valid_email = %w[user@foo.com user@foo.cn user233@164.com user@163.com.cn]
    valid_email.each do |valid|
      @user.email = valid
      assert @user.valid?, "#{valid} not pass"
    end
    recover
  end
  
  test "password should be long enough" do
    @user.password = @user.password_confirmation = "a"*5
    assert_not @user.valid?
  end
  
  test "password should not be blank" do
    @user.password = @user.password_confirmation = " "*6
  end
  
  
end
  
  

