class AddProcessingToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :attachment_processing, :boolean
  end
end
