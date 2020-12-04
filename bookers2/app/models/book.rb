class Book < ApplicationRecord

  belongs_to :user
  attachment :image

  validates :title, presence: true
  validates :body, presence: true

end
