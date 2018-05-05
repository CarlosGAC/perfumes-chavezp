class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.date :day
      t.time :hour
      t.string :place
      t.belongs_to :client, index: true

      t.timestamps
    end
  end
end
