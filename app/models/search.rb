class Search < ActiveRecord::Base

  # Associations
  belongs_to :user

  # Validations
  validates_presence_of :user_id, :state, :zipcode

  default_scope -> { order('created_at DESC') }
end