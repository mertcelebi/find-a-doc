class Search < ActiveRecord::Base

  # Callbacks
  before_save { 
    self.city = city.titleize
    self.address = address.titleize
  }

  # Associations
  belongs_to :user

  # Validations
  validates_presence_of :user_id, :city, :state, :zipcode
  validates :state, length: { is: 2 }
  validates :zipcode, length: { is: 5 }

  default_scope -> { order('created_at DESC') }
end