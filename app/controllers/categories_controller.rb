class CategoriesController < ApplicationController

  def index
    @items = Item.all
    @categories = Category.all.distinct
  end

  def show
    @items = Category.find_by_slug(params[:slug]).items
    @category = @items.first.category
  end

end
