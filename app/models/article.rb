class Article < ApplicationRecord
  # validation for the existence of the title
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :description, presence: true
end
