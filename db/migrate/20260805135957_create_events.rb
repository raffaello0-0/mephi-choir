class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :type
      t.date :event_date
      t.time :start_time
      t.time :end_time
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
