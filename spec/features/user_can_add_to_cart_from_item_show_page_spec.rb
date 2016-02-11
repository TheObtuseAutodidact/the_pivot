require 'rails_helper'

RSpec.feature "logged in user visits item show page" do
	scenario "clicks add to cart button and sees cart updated" do
		store = Store.create(title: "Irma Store", accreditations: ["This is good store"])
		category_1 = create_list(:category_with_items, 5)
		item_1, item_2, item_3, item_4, item_5 = category_1[0].items
		store.items << [item_1, item_2, item_3, item_4, item_5]
    user = create(:user)

    ApplicationController.any_instance.stub(:current_user).and_return(user)

    visit store_item_path(item_1.store.slug, item_1.slug)
    expect(page).to have_content(store.title)
    expect(page).to have_content(store.description)
    expect(page).to have_content("My Cart: 0")


    within "#home-middle" do
      expect(page).to have_content(store.items[2].title)
      expect(page).to have_content(store.items[3].title)
      expect(page).to have_content(store.items[4].title)
    end

    within "#main-item-show" do
      click_on('Add To Cart')
    end

    expect(page).to have_content("My Cart: 1")
    expect(current_path).to eq(store_item_path(item_1.store.slug, item_1.slug))
  end
end
