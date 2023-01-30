class Event < ApplicationRecord
    belongs_to :creator, class_name: 'User'
    def index
        @events = Event.all
    end
end
