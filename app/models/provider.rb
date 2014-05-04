class Provider < ActiveRecord::Base

  # Associations
  belongs_to :hospital
  has_one :specialty

  # Validations
  validates_presence_of :name, :email

end
