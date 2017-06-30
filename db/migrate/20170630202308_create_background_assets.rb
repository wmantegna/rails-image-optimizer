class CreateBackgroundAssets < ActiveRecord::Migration
  def change
    create_table :background_assets do |t|
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.string :attachment_width
      t.string :attachment_height
      t.string :attachment_file_size
      t.text :filesize_metadata
      t.boolean :attachment_processing

      t.timestamps null: false
    end
  end
end
