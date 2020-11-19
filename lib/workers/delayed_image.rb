require 'open-uri'
class DelayedImage < Struct.new(:params)
  include DelayedCallBacks

  def perform
    @job_id = DelayedJobStatus.maximum(:JobId)
    if @job_id == nil
      @job_id = 0
    else
      @job_id += 1
    end
    doc = Nokogiri::HTML(open(params[:url]))
    img_srcs = doc.css('img').map { |i| i['src'] }.uniq.compact
    img_srcs.each do |image_url|
      unless image_url.match(/(;base64)/).present?
        if image_url.match(/^(http|https):/).present?
          store_image(image_url)
        else
          store_image(params[:url].match(/^(http|https):/)[0] + image_url)
        end
      end
    end
  end

  def store_image(image_url)
    open(image_url) do |image|
      name = image_url.split('?')[0].split('/').pop
      unless File.exists?("public/imported-images/#{name}")
        File.open("public/imported-images/#{name}", "wb") do |file|
          begin
            unless Rails.env.test?
              file.write(image.read)
            end
            Image.create!(original_name: name)
          rescue => e
            puts e
            if File.exist?("public/imported-images/#{name}")
              File.delete("public/imported-images/#{name}")
            end
          end
        end
      else
        puts "File exists"
      end
    end
  end
end
