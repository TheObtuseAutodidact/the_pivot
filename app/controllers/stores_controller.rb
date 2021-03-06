class StoresController < ApplicationController
  def show
    @store = Store.find_by_slug(params[:slug])
    @top_sellers = @store.items.first(3)
    @items = @store.items
  end

  def new
    @store = Store.new
  end

  def create
    @store = current_user.stores.create(store_params)
    flash[:notice] = {color: "green", message: "#{@store.title} has been submitted for review."}
    redirect_to root_path
  end

  def dashboard
    render :dashboard
  end

  def edit
    @store = Store.find_by(slug: params[:slug])
  end

  def update
    if params[:store][:status]
      platform_admin_edits_store
    else
      store_admin_edits_store
    end
  end

  private

  def store_params
    params.require(:store).permit(:title, :description, :image_url, :accreditations)
  end

  def store_admin_edits_store
    store = current_user.store
    store.update_attributes(store_params)
    if store.save
      flash[:success] = {color: "white", message: "Store #{store.title} has been successfully updated"}
      redirect_to store_dashboard_index_path(store.slug)
    else
      flash[:errors] = {color: "white", message: store.errors.full_messages.join(", ") }
      redirect_to :back
    end
  end

  def platform_admin_edits_store
    store = Store.find_by(slug: params[:slug])
    store.update_attributes(store_params)
    store.status = params[:store][:status]
    if current_user.platform_admin? && store.save
      flash[:success] = {color: "white", message: "Store #{store.title} is now #{store.status}"}
      redirect_to platform_admin_dashboard_index_path
    else
      flash[:error] = { color: "white", message: store.errors.full_messages.join(", ") }
      redirect_to platform_admin_dashboard_index_path
    end
  end
end
