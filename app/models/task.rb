class Task < ApplicationRecord
  belongs_to :list

  belongs_to :user, optional: true
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories, allow_destroy: true

  validates :title, presence: true

  include RankedModel
  ranks :row_order, with_same: :list_id

  after_create_commit -> { broadcast_reload }
  after_update_commit -> { broadcast_reload }
  after_destroy_commit -> { broadcast_reload }

  private

  def broadcast_reload
    Turbo::StreamsChannel.broadcast_action_to(
      "task_changes",
      action: "reload",
      target: "body"
    )
  end
end
