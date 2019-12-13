class CreateGratefulReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :grateful_reminders do |t|
      t.integer :user_id
      t.string :message_sent

      t.timestamps
    end
  end
end
