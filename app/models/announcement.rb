class Announcement < ApplicationRecord
    validates :title, :content, presence: true
    validates :title, length: { maximum: 128 }
    before_save :stripping_names
    protected
    def stripping_names
      self.title = self.title.strip
      self.content = self.content.strip
    end
end
