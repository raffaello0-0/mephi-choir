class AddUserRefToAnnouncement < ActiveRecord::Migration[8.1]
  def change
    add_reference :announcements, :user, null: false, foreign_key: true
  end
end
