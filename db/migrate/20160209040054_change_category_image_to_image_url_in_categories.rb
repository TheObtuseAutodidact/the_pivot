class ChangeCategoryImageToImageUrlInCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :category_image
    add_column :categories, :image_url, :string
  end
end
