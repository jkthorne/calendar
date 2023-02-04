require "uri"

require "./vevent"

class Calendar::VCalendar
  property prodid : String
  property version : String
  property calscale : String?
  property method : String?
  property name : String?
  property description : String?
  property uid : String?
  property last_modified : Time? # NOTE: DateTime
  property url : URI?
  property categories : String?
  property refresh_interval : String? # NOTE: durration type
  property source : URI?              # NOTE: uri
  property color : String?
  property image : URI? # NOTE: uri
  # property timezone String? , :tzid
  property events : Array(VEvent) = [] of VEvent

  # property todo : Array(VTODO)
  # property journal : Array(VJournal)
  # property freebusy : Array(VFreebusy)

  def initialize(
    @prodid = "crystal",
    @version = "2.0", # TODO: restrict version to 1.0 and 2.0
    @calscale = nil,  # TODO: restrict calscale to know values "GREGORIAN"
    @method = nil,
    @name = nil,
    @description = nil,
    @uid = nil,
    @last_modified = nil, # NOTE: DateTime
    @url = nil,           # NOTE: uri
    @categories = nil,
    @refresh_interval = nil, # NOTE: durration type
    @source = nil,           # NOTE: uri
    @color = nil,
    @image = nil # NOTE: uri
  )
  end

  def publish
    @ip_method = "PUBLISH"
  end

  def render : String
    String.build do |str|
      render(str)
    end
  end

  def render(io)
    io.puts "BEGIN:VCALENDAR"
    io.puts "VERSION:#{version}"
    io.puts "PRODID:#{prodid}"
    io.puts "CALSCALE:#{calscale}" if calscale
    io.puts "METHOD:#{method}" if method
    io.puts "DESCRIPTION:#{description}" if description
    events.each(&.render(io)) if events.any?
    io.puts "END:VCALENDAR"
  end
end
