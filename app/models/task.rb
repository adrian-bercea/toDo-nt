class Task < ApplicationRecord
  acts_as_list scope: :list
  belongs_to :list

  belongs_to :user, optional: true
  has_and_belongs_to_many :categories
  has_rich_text :description
  accepts_nested_attributes_for :categories, allow_destroy: true

  validates :title, presence: true
  # Update broadcast to include list changes
  after_update_commit :broadcast_list_if_changed

  private

  def broadcast_list_if_changed
    return unless saved_change_to_position? || saved_change_to_list_id?

    # If list changed, broadcast both lists
    if saved_change_to_list_id?
      old_list_id, new_list_id = saved_change_to_list_id
      [ old_list_id, new_list_id ].compact.each do |list_id|
        broadcast_list(list_id)
      end
    else
      broadcast_list(list_id)
    end
  end

  def broadcast_list(list_id)
    list = List.find(list_id)

    # Force reload to get the latest positions
    list.tasks.reload

    Turbo::StreamsChannel.broadcast_replace_to(
      "lists",
      target: "list_#{list_id}_tasks",
      partial: "lists/tasks",
      locals: { list: list }
    )
  end
end
