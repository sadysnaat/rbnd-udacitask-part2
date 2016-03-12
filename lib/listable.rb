module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(30)
  end
  def format_date(options={})
    if options.key? :start_date or options.key? :end_date
      formatted_date = options[:start_date].strftime("%D") if options[:start_date]
      formatted_date +=  ' -- ' + options[:end_date].strftime("%D") if options[:end_date]
      formatted_date = 'N/A' if !formatted_date
    end

    if options.key? :due_date
      formatted_date = options[:due_date].strftime("%D") if options[:due_date].is_a? Time
      formatted_date = "No due date" if !formatted_date
    end
    return formatted_date
  end
  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:yellow) if priority == "medium"
    value = " ⇩".colorize(:green) if priority == "low"
    value = "" if !priority
    return value
  end
end
