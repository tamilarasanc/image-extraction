require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test "has a 200 status code" do
    get :index
    expect(response.status).to eq(200)
  end
end

