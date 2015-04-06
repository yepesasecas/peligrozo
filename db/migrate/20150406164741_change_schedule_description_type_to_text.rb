class ChangeScheduleDescriptionTypeToText < ActiveRecord::Migration

  def up
    change_column :schedules, :description, :text, limit: nil
  end

  def down
    change_column :schedules, :description, :string
  end
end
