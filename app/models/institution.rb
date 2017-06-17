class Institution < ActiveRecord::Base
  belongs_to :state
  belongs_to :grouping

  validates :contact_info, :email, :state_id, :grouping_id, presence: true
end
