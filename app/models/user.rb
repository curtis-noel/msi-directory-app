class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable

  validates :username, presence: true
end
