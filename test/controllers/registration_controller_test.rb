require 'test_helper'

class RegistrationControllersTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get registration_create_url
    assert_response :success
  end

end
