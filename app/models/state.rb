class State < ActiveRecord::Base
  has_many :institutions
  belongs_to :region

  validates :name, :abbreviation, presence: true
end
