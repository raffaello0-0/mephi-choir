class Event < ApplicationRecord
    #вычисление времени окончания и проверка чтобы занятия не накладывались друг на друга
    validates :event_type, inclusion: {in: ['competition', 'concert', 'repetition']}
    validates :title, :event_type, :event_date, :start_time, :location,  presence: true
    validates :title, length: {maximum: 128}
    validates :location, length: {maximum: 256}
end

