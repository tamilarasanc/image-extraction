class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :original_name
      t.string :alt
      t.string :display_name
      t.string :path
      t.timestamps
    end
  end
end
