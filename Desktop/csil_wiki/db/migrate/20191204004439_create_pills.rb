class CreatePills < ActiveRecord::Migration[6.0]
  def change
    create_table :pills do |t|
      t.integer :user_id
      t.string :name
      t.string :pill_time
      t.string :description

      t.timestamps
    end
  end
end
