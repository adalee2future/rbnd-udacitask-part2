class Interactive
  def self.input_guide
    puts "*" * 40
    puts "You can add three kind of item: event, link, todo."
    puts "Format is shown below\n"
    puts "event|description here|start date here|end date here"
    puts "link|url here|sitename here"
    puts "todo|description here|due date here|priority here (high, medium, low supported)"
  end

  def self.create_udaci_list
    # User input here
    cli = HighLine.new
    answer = cli.ask "Do you want to have your own UdaciList? (yes/no)"
    if answer.start_with? "y"
      user_list = UdaciList.new(title: "Your Stuff")
      while true
        input_guide
        answer = cli.ask("\nAdd items to UdaciList, type end to quit.")
        if answer == "end"
          break
        end
        tokens = answer.split("|")
        if tokens[0] == "event"
          _, description, start_date, end_date = tokens
          user_list.add("event", description, start_date: start_date, end_date: end_date)
        elsif tokens[0] == "link"
          _, url, site_name = tokens
          user_list.add("link", url, site_name: site_name)
        elsif tokens[0] == 'todo'
          _, description, due, priority = tokens
          user_list.add("todo", description, due: due, priority: priority)
        else
          puts "wrong format"
          break
        end
      end
      user_list
    end
  end
end

