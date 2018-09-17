class AddDownloadCountToLink < ActiveRecord::Migration[5.2]
  def change
  	add_column :links, :download_count, :integer, :default => 0
  end
end
