class UdaciList
  attr_reader :title, :items

  @@untitled_lists = 0
  @@valid_types = ["todo","event","link"]

  def initialize(options={})
    if options[:title]
      @title = options[:title]
    else
      #This is done so that two untitled lists don't share same name
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
  def delete(*indices)
    indices.each do |index|
      if index > @items.length
        raise UdaciListErrors::IndexExceedsListSize, "Item #{index - 1} not in the list"
      end
      @items.delete_at(index - 1)
    end
  end
  def all
    print_list(@items, @title)
  end
  def filter(list_type)
    result = []
    @items.each do |item|
      if item.class.to_s.sub('Item','').downcase == list_type
        result << item
      end
    end
    if result.length == 0
      raise UdaciListErrors::ItemNotFound, "No item of type #{list_type} found."
    end
    print_list(result, "#{@title} - #{list_type} only")
  end
  def self.untitled_lists
    @@untitled_lists
  end
  def item_at_index(index)
    return @items.at(index - 1)
  end

  private
  def print_list(items, title)
    rows = []
    items.each_with_index do |item, position|
      rows << [position+1,item.class.to_s.sub('Item','')] + item.details
    end
    table = Terminal::Table.new :title => title, :headings => ['No','Type','Item', 'Info'], :rows => rows
    puts table
  end
end
