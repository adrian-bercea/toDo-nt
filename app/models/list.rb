class List < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true

  include RankedModel
  ranks :row_order

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
