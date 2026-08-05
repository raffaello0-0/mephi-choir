class CreateAnnouncements < ActiveRecord::Migration[8.1]
  def change
    create_table :announcements do |t|
      t.string :title, null: false, limit: 128
      t.text :content, null: false

      t.timestamps
    end
  end
end
