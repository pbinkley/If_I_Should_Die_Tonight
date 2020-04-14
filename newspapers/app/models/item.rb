class Item < ApplicationRecord
  has_one_attached :thumbnail
  belongs_to :category
end
