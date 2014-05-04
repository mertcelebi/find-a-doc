class Symptom < ActiveRecord::Base

  # Associations
  belongs_to :specialty

  # Validations
  validates_presence_of :name

end
