class Event < ApplicationRecord
    def index
        @events = Event.all
    end
end
