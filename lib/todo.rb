class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  @@valid_priorities = ["low", "medium", "high"]

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    if !@@valid_priorities.include? options[:priority] and options[:priority]
      raise UdaciListErrors::InvalidPriorityValue, "#{options[:priority]} is not a valid priority"
    end
    @priority = options[:priority]
  end
  def details
    return [format_description(@description), format_date(due_date: @due) + format_priority(@priority)]
  end
end
