module UdaciListErrors
  # Error classes go here
  class InvalidItemType < StandardError
  end
  class IndexExceedsListSize < StandardError
  end
  class InvalidPriorityValue < StandardError
  end
  class ItemNotFound < StandardError
  end
  class InvalidICalendarObject < StandardError
  end
end
