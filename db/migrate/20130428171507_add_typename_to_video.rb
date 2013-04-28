class AddTypenameToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :typename, :string
  end
end
