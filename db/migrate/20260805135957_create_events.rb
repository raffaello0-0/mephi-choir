class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title, null: false, limit: 128
      t.string :event_type, null: false
      t.date :event_date, null: false
      t.time :start_time, null: false
      t.string :location, null: false, limit: 256
      t.text :description

      t.timestamps
    end
    add_check_constraint :events, "event_type IN('competition', 'concert', 'repetition')", name: 'event_type_check'
  end
end
