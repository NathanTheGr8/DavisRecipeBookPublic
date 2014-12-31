class AddIngredentsToRecipes < ActiveRecord::Migration
  def change
  	add_column :recipes, :ingredents, :text
  end
end
