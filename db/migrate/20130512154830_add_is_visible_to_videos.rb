class AddIsVisibleToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :is_visible, :boolean, :default => true
  end
end
