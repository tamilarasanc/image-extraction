class ImagesController < ApplicationController
  require 'open-uri'
  def index
    @images = Image.all
  end

  def create
    params = allowed_params
    uri = URI.parse(params[:url])
    if uri.host.present?
      if Rails.env.test?
        DelayedImage.new(params).perform
      else
        Delayed::Job.enqueue(DelayedImage.new(params), :queue => "extract_images", :run_at => Time.now)
      end
      flash[:message] = "Extract will take some time reload page after some time"
    else
      flash[:message] = "Please enter valid url to extract images"
    end
    redirect_to :action => 'index'
  end

  private
  def allowed_params
    params.permit(:url)
  end
end
