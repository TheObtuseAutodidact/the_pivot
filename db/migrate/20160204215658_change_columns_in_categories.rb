class ChangeColumnsInCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :sponsor_image
    remove_column :categories, :sponsor_title
    add_column    :categories, :image_url, :string
  end
end
