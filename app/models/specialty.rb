class Specialty < ActiveRecord::Base

  # Associations
  belongs_to :provider
  has_many :icd9s
  has_many :symptoms

  # Validations
  validates_presence_of :name

end
