class Image < ApplicationRecord
  validates :original_name, format: { with: /[\w-]+\.(jpg|png|jpeg|svg)/,
                                      message: "only proper image name supports" },
            uniqueness: { case_sensitive: false }

  after_find :load_path

  after_destroy_commit :delete_file_source, on: :destroy

  def load_path
    self.path = "/imported-images/#{self.original_name}"
  end

  def delete_file_source
    unless Rails.env.test?
      puts "delete"
      if File.exist?("public#{self.path}")
        File.delete("public#{self.path}")
      end
    end
  end
end
