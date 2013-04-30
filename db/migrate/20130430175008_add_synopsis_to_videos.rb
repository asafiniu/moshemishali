class AddSynopsisToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :synopsis, :text
  end
end
