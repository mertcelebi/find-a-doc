class Hospital < ActiveRecord::Base

  # Associations
  has_many :providers
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name

end
