class Task < ApplicationRecord
  belongs_to :list

  belongs_to :user, optional: true
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories, allow_destroy: true

  validates :title, presence: true

  include RankedModel
  ranks :row_order, with_same: :list_id

  private
end
