class Dog < ApplicationRecord

  has_many_attached :images
  belongs_to :owner , :class_name => "User"

  scope :for_owner, ->(user_id) { where("owner_id = ?", user_id) }
end
