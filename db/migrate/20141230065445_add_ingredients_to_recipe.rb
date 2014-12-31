class AddIngredientsToRecipe < ActiveRecord::Migration
  def change

  	remove_column :recipes, :body, :text
  	add_column :recipes, :ingredients, :text
  	add_column :recipes, :instructions, :text
  	add_column :recipes, :description, :text

  end
end
