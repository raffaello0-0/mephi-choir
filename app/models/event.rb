class Event < ApplicationRecord
    validates :event_type, inclusion: { in: [ "competition", "concert", "repetition" ] }
    validates :title, :event_type, :event_date, :start_time, :location,  presence: true
    validates :title, length: { maximum: 128 }
    validates :location, length: { maximum: 256 }
    before_validation :stripping_names
    validates_each :start_time do |record, attr, value|
      bad_events = Event.where(event_date: record.event_date, location: record.location).where.not(id: record.id).select { |event| (event.start_time + 45.minutes > value) && (value + 45.minutes > event.start_time) }
      if bad_events.any?
        record.errors.add(attr, "intersects with another event at this location")
      end
    end
    validates_each :start_time do |record, attr, value|
      sum_min = value.hour * 60 + value.min
      unless (8 * 60..22 * 60).include?(sum_min)
        record.errors.add(attr, "time should be between 08:00 and 22:00")
      end
    end
    protected
    def stripping_names
      self.title = self.title.strip
      self.location = self.location.strip
      self.description = self.description.strip
    end
end
