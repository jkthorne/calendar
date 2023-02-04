require "uuid"
require "uri"

require "./vevent"
require "./vcalendar"

module Calendar
  VERSION = "0.1.0"

  class Calendar
    getter calendar

    def initialize(@calendar : VCalendar)
    end

    def render : String
      String.build do |str|
        render(str)
      end
    end

    def render(io) : Nil
      calendar.render(io)
    end
  end
end
