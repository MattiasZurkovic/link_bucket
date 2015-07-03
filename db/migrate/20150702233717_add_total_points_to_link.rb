class AddTotalPointsToLink < ActiveRecord::Migration
  def change
    add_column :links, :points, :integer, :default => 0
  end
end
