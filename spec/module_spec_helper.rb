module ModelSpecHelper
  def create_sample_images
    ["test.jpg","test1.jpg","test2.jpg"].each do |image_name|
      Image.create(original_name: image_name)
    end
  end

  def delete_sample_images
    Image.destroy_all
  end
end
