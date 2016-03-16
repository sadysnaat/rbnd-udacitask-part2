class UdaciList
  attr_reader :title, :items

  @@untitled_lists = 0
  @@valid_types = ["todo","event","link"]

  def initialize(options={})
    if options[:title]
      @title = options[:title]
    else
      @title = "Untitled List"
      if @@untitled_lists > 0
        @title += " #{@@untitled_lists}"
      end
      @@untitled_lists += 1
    end
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    if !@@valid_types.include? type
      raise UdaciListErrors::InvalidItemType, "#{type} is not a valid Udacilist Item"
    end
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  def delete(index)
    print @items.length
    if index > @items.length
      raise UdaciListErrors::IndexExceedsListSize, "Item #{index - 1} not in the list"
    end
    @items.delete_at(index - 1)
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
  def self.untitled_lists
    @@untitled_lists
  end
end
