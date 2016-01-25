class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    if !['todo', 'event', 'link'].include? type
      raise UdaciListErrors::InvalidItemType
    end
    if (options.has_key? :priority) &&(!["low", "high", "medium"].include? options[:priority])
      raise UdaciListErrors::InvalidPriorityValue
    end
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  def delete(index)
    if index < 1 || index > @items.size
      raise UdaciListErrors::IndexExceedsListSize
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
end
