FactoryGirl.define do

# //  Useful Methods
#       Create 1 Object
#         store = create(:store)
#         item = create(:item)
#
#       Create Multiple Objects
#         store_1, store_2 = create_list(:store, 2)
#         item_1, item_2, item_3 = create_list(:store, 3)
#         users = create_list(:user, 20)
#           user_1 = users[1]
#           user_2 = users[2]
#
#       Create Associated Objects
#         category_1 = create(:category_with_items, items_count: 5)
#           item_1 = category_1.items[0]
#           item_2 = category_1.items[1]
#         item_1, item_2 = create(:category_with_items, items_count: 2).items


# // Create Items

  factory :item do
    title
    description
    price
    image_url "http://www.mamashealth.com/allergies/images/trees.jpg"
  end

  sequence :title do |n|
    "#{n} Item"
  end

  sequence :description do |n|
    "#{n} Description"
  end

  sequence :price do |n|
    n * 1000
  end

# // Create Categories, Categories with Items

  category_titles = ["Carbon Offsets",
                     "Wind Farm Certificates",
                     "Clean Water Initiatives",
                     "Waste Heat Recovery",
                     "Forest Management Trust"]

  sequence :category_title, category_titles.cycle do |n|
    "#{n}"
  end

  sequence :slug do |n|
    "#{n}-slug"
  end

  factory :category do
    title { generate(:category_title) }
    slug
    image_url "https://static.pexels.com/photos/2759/clouds-cloudy-forest-trees.jpg"

    factory :category_with_items do
      transient do
        items_count 5
      end

      after(:create) do |category, evaluator|
        create_list(:item, evaluator.items_count, category: category)
      end
    end
  end

# // Create Users

  factory :user do
    first_name
    last_name
    username
    role 0
    password "password"
  end

  sequence :first_name do |n|
    "#{n}First"
  end

  sequence :last_name do |n|
    "#{n}Last"
  end

  sequence :username do |n|
    "#{n}FirstLast"
  end

# // Create Orders

  factory :order do
    status "ordered"
    total_price 5000
  end

  factory :order_item do
    item_quantity 1
    item_price 1000
  end

# // Create Stores

  factory :store do
    title         { generate(:store_title) }
    description   { generate(:store_description) }
    status        "submitted"
    image_url     "http://www.businesswaste.co.uk/wp-content/uploads/2013/09/carbon-neutral.jpeg"
    accreditations ['Nature Conservancy']
  end

  sequence :store_title do |n|
    "#{n} Store Title"
  end

  sequence :store_description do |n|
    "#{n} Store Description"
  end
end
