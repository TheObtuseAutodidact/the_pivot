class Seed
  def self.start
    seed = Seed.new
    seed.generate_categories
    seed.generate_stores
    seed.generate_items
    seed.generate_platform_admin
    seed.generate_customers
    seed.generate_orders
  end

  def generate_categories
    10.times do |i|
      category = Category.create!(
        title: category_names[i],
        slug: category_names[i].parameterize,
        image_url: "http://lorempixel.com/300/300/nature/#{i}/"
        )
      puts "Category #{i}: #{category.title} created!"
    end
  end

  def generate_items
    categories = Category.all
    categories.each do |category|
      50.times do |i|
        item = category.items.create!(
        title: "#{Faker::Commerce.product_name} (#{Random.new.rand(1..99999)})",
        description: Faker::Lorem.sentence(3),
        price: Faker::Number.between(1, 10000),
        image_url: "http://mightytreemovers.com/wp-content/uploads/2013/05/tree.jpg",
        )
        Store.all.sample.items << item
        puts "#{category.title.capitalize}'s Item #{i}: Item #{item.title} created!"
      end
    end
  end

  def generate_store_admin
    if Store.all.count == 0
      store_admin = User.create!(
        first_name: "andrew",
        password: "password",
        username: "acarmer",
        last_name: "carmer",
        role: 1.to_i
      )
    else
      store_admin = User.create!(
        first_name: Faker::Name.first_name,
        password: "password",
        username: Faker::Internet.user_name,
        last_name: Faker::Name.last_name,
        role: 1.to_i
      )
    end
  end

  def generate_stores
    20.times do |i|
      store_admin = generate_store_admin
      store = Store.create!(
        title: Faker::Company.name,
        description: Faker::Lorem.sentence(1),
        status: "active",
        image_url: "http://lorempixel.com/300/300/abstract/#{(i/2)}/",
        accreditations: ["National Audubon Society"],
        user_id: store_admin.id
        )
      puts "Store #{i}: #{store.title} created with #{store_admin.last_name} as admin!"
    end
  end

  def generate_platform_admin
    platform_admin = User.create!(
      first_name: "jorge",
      password: "password",
      username: "jtellez",
      last_name: "tellez",
      role: 2.to_i
    )
    puts "Platform Admin: #{platform_admin.last_name} created!"
  end

  def generate_customers
    100.times do |i|
      customer = User.create!(
        first_name: Faker::Name.first_name,
        password: "password",
        username: "#{Faker::Internet.user_name} (#{Random.new.rand(1..99999)})",
        last_name: Faker::Name.last_name,
        role: 0.to_i
      )
      puts "Customer #{i}: #{customer.last_name} created!"
    end
  end

  def generate_orders
    customers = User.where(role: 0)
    customers.each do |customer|
      10.times do |i|
        items = [ Item.find(rand(1..500)), Item.find(rand(1..500)), Item.find(rand(1..500))]
        order = customer.orders.create!(
          status: order_status.sample,
          total_price: items.map { |item| item.price }.reduce(:+)
        )
        order.items << items
        puts "#{customer.last_name.capitalize}'s order ##{i} created! Includes items ##{items[0].id}, ##{items[1].id}, ##{items[2].id}."
      end
    end
  end

  private

    def category_names
      [ "Carbon Offsets Sector Incubator",
        "Cookstoves Carbon Offsets Certicates",
        "Domestic Behavior Change Programs",
        "Wastewater BioGas-to-Energy Programs",
        "Geothermal Energy Initiatives",
        "Biomass Fuel Switch Certificates",
        "Coal Mine Methane Reduction Programs",
        "Reforestation Initiatives",
        "Wind Power Prototyping Fund",
        "HydroPower Innovation Fund",
      ]
    end

    def order_status
      ["completed", "cancelled", "paid", "pending"]
    end
end

Seed.start
