class AddFileSizeMetaDataToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :filesize_metadata, :text 
  end
end
