class AddServingSizeToRecipes < ActiveRecord::Migration
  def change
  	add_column :recipes, :servingsize, :integer, :default => 4
  end
end
