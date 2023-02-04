require "uuid"
require "uri"

class Calendar::VEvent
  struct Geo
    getter lat : Float32
    getter lng : Float32

    def initialize(@lat : Float32, @lng : Float32)
    end

    def render
      String.build do |str|
        render(str)
      end
    end

    def render(io)
      io.puts "GEO:#{lat};#{lng}"
    end
  end

  property dtstamp : Time
  property uid : UUID
  property dtstart : Time
  property dtend : Time
  property duration : Time::Span? # NOTE: Durration
  property ip_class : String?
  property color : String?
  property created : Time?
  property description : String?
  property geo : Geo?
  property last_modified : Time?
  property location : String?
  # property organizer, Icalendar::Values::CalAddress
  property priority : Int32?
  property sequence : Int32?
  property status : String? # TODO: restrict to enum
  property summary : String?
  property transp : String?
  property url : URI?
  property recurrence_id : Time?
  # property rrule TODO: create struct for this
  property attach : URI?
  # property attendee, Icalendar::Values::CalAddress
  property categories : String?
  property comment : String?
  property contact : String?
  property exdate : Time?
  property request_status : String?
  property related_to : String?
  property resources : String?
  property rdate : Time?
  property conference : URI?
  property image : URI?

  # property alarms : Array(VAlarm)

  # TODO: dtrend and duration are exclusive
  def initialize(
    @dtstamp = Time.utc,
    @uid = UUID.random,
    @dtstart = Time.utc,
    @dtend = Time.utc,
    @duration = nil,
    @ip_class = nil,
    @color = nil,
    @created = nil,
    @description = nil,
    @geo = nil,
    @last_modified = nil,
    @location = nil,
    @priority = nil,
    @sequence = nil,
    @status = nil,
    @summary = nil,
    @transp = nil,
    @url = nil,
    @recurrence_id = nil,
    @attach = nil,
    @categories = nil,
    @comment = nil,
    @contact = nil,
    @exdate = nil,
    @request_status = nil,
    @related_to = nil,
    @resources = nil,
    @rdate = nil,
    @conference = nil,
    @image = nil
  )
  end

  def render : String
    String.build do |str|
      render(str)
    end
  end

  def render(io)
    io.puts "BEGIN:VEVENT"

    io.puts "SUMMARY:#{summary}" if summary
    io.puts "UID:#{uid}"
    io.puts "SEQUENCE:#{sequence}" if sequence
    io.puts "STATUS:#{status}" if status
    io.puts "TRANSP:#{transp}" if transp
    io.puts "DTSTART:#{dtstart.to_s("%Y%m%dT%H%M%S")}"
    io.puts "DTEND:#{dtend.to_s("%Y%m%dT%H%M%S")}"
    io.puts "DTSTAMP:#{dtstamp.to_s("%Y%m%dT%H%M%S")}"
    io.puts "CATEGORIES:#{categories}" if categories
    io.puts "LOCATION:#{location}" if location
    geo.try &.render(io)
    io.puts "DESCRIPTION:#{description}" if description
    io.puts "URL:#{url}" if url
    io.puts "END:VEVENT"
  end
end
