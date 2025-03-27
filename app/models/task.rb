class Task < ApplicationRecord
  acts_as_list top_of_list: 0

  belongs_to :user, optional: true
  has_and_belongs_to_many :categories
  has_rich_text :description
  accepts_nested_attributes_for :categories, allow_destroy: true

  validates :title, presence: true

  # Add broadcasting support
  broadcasts_to ->(task) { "tasks" }, inserts_by: :prepend
  after_update_commit :broadcast_list_if_position_changed

  private

  def broadcast_list_if_position_changed
    return unless saved_change_to_position?

    # Get ordered tasks and broadcast the replacement
    tasks = Task.order(:position)
    Turbo::StreamsChannel.broadcast_replace_to(
      "tasks",
      target: "tasks_list",
      partial: "tasks/list",
      locals: { tasks: tasks }
    )
  end
end
