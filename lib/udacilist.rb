class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    unless ['todo', 'event', 'link'].include? type
      raise UdaciListErrors::InvalidItemType, 'item type should be "todo", "event", or "link"!'
    end
    if (options.has_key? :priority) &&(!["low", "high", "medium"].include? options[:priority])
      raise UdaciListErrors::InvalidPriorityValue, 'priority should be "low", "medium" or "high"!'
    end
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  def delete(index)
    if index < 1 || index > @items.size
      raise UdaciListErrors::IndexExceedsListSize, "index should be between 1 and item size!"
    end
    @items.delete_at(index - 1)
  end
  def all
    rows = []
    headings = ["num", "description"]
    @items.each_with_index do |item, position|
      rows.push([position+1, item.details])
    end
    table = Terminal::Table.new :title => @title, :headings => headings, :rows => rows
    puts table
    puts "\n\n"
  end
  def filter(type)
    item_class = { "todo" => TodoItem, "event" => EventItem, "link" => LinkItem }
    rows = @items.select { |item| item.class == item_class[type] }.map { |item| [item.details] }
    Terminal::Table.new :title => type, :rows => rows
  end
end
