class Task < ApplicationRecord
  has_and_belongs_to_many :categories
  has_rich_text :description
  accepts_nested_attributes_for :categories, allow_destroy: true
end
