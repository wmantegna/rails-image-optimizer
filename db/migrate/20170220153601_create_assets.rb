class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.string :attachment_width
      t.string :attachment_height
      t.string :attachment_file_size
      t.timestamps
    end
  end
end
