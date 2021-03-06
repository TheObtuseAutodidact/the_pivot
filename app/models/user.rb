class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :reviews
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: { message: "%{value} is already taken. Please choose a different username"}
  enum role: %w(default store_admin platform_admin)
  has_many :stores

  def total_purchased
    orders.sum(:total_price)
  end

  def store
    Store.find_by(user_id: self.id)
  end
end
