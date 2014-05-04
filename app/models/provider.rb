class Provider < ActiveRecord::Base

  # Associations
  belongs_to :hospital
  has_one :specialty
  has_attached_file :avatar, :styles => 
    { :medium => "300x300>", :thumb => "100x100>" }, :default_url => 
    "/images/:style/missing.jpeg"

  # Validations
  validates_presence_of :name, :email
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
