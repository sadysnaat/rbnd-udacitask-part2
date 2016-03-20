class TodoItem
  include Listable
  include Recurrent
  attr_reader :description, :due, :priority

  @@valid_priorities = {low: 6, medium: 5, high: 1} # From iCalendar RFC 5545 https://tools.ietf.org/html/rfc5545#section-3.8.1.9
  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    set_priority(options[:priority])
  end
  def details
    return [format_description(@description), format_date(due_date: @due) + format_priority(@priority)]
  end
  def change_priority(priority)
    set_priority(priority)
  end
  def recurrence(options={})
    @recurrence = add_recurrence(options)
  end
  def export_to_ics(list_title)
    if @due
      cal = Icalendar::Calendar.new
      cal.todo do |t|
        t.priority = @@valid_priorities[@priority.to_sym] if @priority
        t.due = @due
        t.summary = @description
        t.rrule = @recurrence.to_ical if @recurrence
      end
      cal_file = File.open("#{list_title} #{@description}.ics",'w+')
      cal_file.write(cal.to_ical)
    else
      raise UdaciListErrors::InvalidICalendarObject, "due date/time is required for valid iCalendar Object"
    end
  end

  private
  def set_priority(priority)
    if priority
      priority.downcase!
      if @@valid_priorities.include? priority.to_sym
        @priority = priority
      else
        raise UdaciListErrors::InvalidPriorityValue, "#{priority} is not a valid priority"
      end
    end
  end
end
