class Announcement < ApplicationRecord
    validates :title, :content, presence: true
    validates :title, length: {maximum: 128}
end
