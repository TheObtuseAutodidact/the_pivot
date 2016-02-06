require 'rails_helper'

RSpec.feature "guest visits item page" do
	scenario "and sees item details" do
		store = Store.create(title: "test", accreditation: "Hurray")
		store_2 = Store.create(title: "bad store", accreditation: "booooo")
		category_1 = create_list(:category_with_items, 5)
		category_2 = create_list(:category_with_items, 1)
		item_1, item_2, item_3, item_4, item_5 = category_1[0].items
		item_6, item_7, item_8, item_9, item_10 = category_2[0].items
		store.items << [item_1, item_2, item_3, item_4, item_6, item_7, item_8, item_9, item_10]
		store_2.items << item_5

		visit store_path(store)

		expect(page).to have_content(store.title)
    expect(page).to have_content(store.description)
		expect(page).to have_content(store.accreditation)
    # binding.pry
		within "#home-middle" do
			expect(page).to have_content(store.items[8].title)
			expect(page).to have_content(store.items[7].title)
			expect(page).to have_content(store.items[6].title)
			expect(page).to_not have_content(item_5.title)
		end

    within "#item-index" do
      expect(page).to_not have_content(item_5.title)
    end
	end
end


# As a guest,
# when I visit a store’s page,
# I see the store’s profile information, and
# I see the store’s accreditations, and
# I see the store’s top selling items, and
# I see a list of all items sold by that shop, and
# I do not see items sold by other shops