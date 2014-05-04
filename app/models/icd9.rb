class Icd9 < ActiveRecord::Base

  # Associations
  belongs_to :specialty

  # Validations
  validates_presence_of :name, :icd9_code
  validates_uniqueness_of :icd9_code

end
