class List < ApplicationRecord
  acts_as_list
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true

  broadcasts_to ->(list) { "lists" }
end
