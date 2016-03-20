class EventItem
  include Listable
  include Recurrent
  attr_reader :description, :start_date, :end_date

  def initialize(description, options={})
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
    if @start_date and options[:all_day]
      # For iCalendar Objects to easilt set all day events
      @start_date = @start_date.beginning_of_day
      @end_date = @start_date.end_of_day
    end
  end

  def recurrence(options={})
    @recurrence = add_recurrence(options)
  end

  def export_to_ics(list_title)
    if @start_date and @end_date
      cal = Icalendar::Calendar.new
      cal.event do |e|
        e.dtstart = @start_date
        e.dtend = @end_date
        e.summary = @description
        e.rrule = @recurrence.to_ical if @recurrence
      end
      cal_file = File.open("#{list_title} #{@description}.ics",'w+')
      cal_file.write(cal.to_ical)
    elsif @start_date
      raise UdaciListErrors::InvalidICalendarObject, "end date is required for valid event iCalendar Object"
    elsif @end_date
      raise UdaciListErrors::InvalidICalendarObject, "start date is required for valid event iCalendar Object"
    else
      raise UdaciListErrors::InvalidICalendarObject, "start date and end date is required for valid event iCalendar Object"
    end
  end
  def details
    return [format_description(@description), format_date(start_date: @start_date, end_date: @end_date)]
  end
end
