class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  @@valid_priorities = ["low", "medium", "high"]

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

  private
  def set_priority(priority)
    if !@@valid_priorities.include? priority and priority
      raise UdaciListErrors::InvalidPriorityValue, "#{priority} is not a valid priority"
    end
    @priority = priority
  end
end
