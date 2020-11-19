require 'rails_helper'

describe ImagesController, :type => :controller  do
  include ModelSpecHelper
  context "get all images" do
    before(:each) do
      create_sample_images
    end

    after(:each) do
      delete_sample_images
    end
    describe "action" do
      it "index" do
        get :index
        expect(Image.count).to eql(5)
        expect(response.status).to eq(200)
      end
    end
  end
  context "input validates" do
    describe "url" do
      it 'valid' do
        get :create, :params => { :url => "https://api.github.com/" }
        expect(flash[:message]).to match("Extract will take some time reload page after some time")
        expect(response.status).to eq(302)
      end

      it 'invalid' do
        get :create, :params => { :url => "test" }
        expect(flash[:message]).to match("Please enter valid url to extract images")
        expect(response.status).to eq(302)
      end
    end
  end
end
