class List < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true

  include RankedModel
  ranks :row_order
end
