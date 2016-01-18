# require 'rails_helper'
#
# RSpec.feature "visitor can add items to cart" do
#   scenario "cart shows number of items in cart" do
#
#     db_repo = FactoryJordan.new
#     db_repo.create_travesty(1)
#
#     visit '/items'
#
#     expect(page).to have_content("My Cart: 0")
#
#     first(:button, 'Add to cart').click
#
#     expect(page).to have_content("My Cart: 1")
#     expect(page).to have_content("You have 1 item in your cart.")
#   end
# end
