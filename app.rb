require 'chronic'
require 'colorize'
# Find a third gem of your choice and add it to your project
require 'terminal-table'
require 'highline'

require_relative "lib/listable"
require_relative "lib/errors"
require_relative "lib/udacilist"
require_relative "lib/todo"
require_relative "lib/event"
require_relative "lib/link"

list = UdaciList.new(title: "Julia's Stuff")
list.add("todo", "Buy more cat food", due: "2016-02-03", priority: "low")
list.add("todo", "Sweep floors", due: "2016-01-30")
list.add("todo", "Buy groceries", priority: "high")
list.add("event", "Birthday Party", start_date: "2016-05-08")
list.add("event", "Vacation", start_date: "2016-05-28", end_date: "2016-05-31")
list.add("link", "https://github.com", site_name: "GitHub Homepage")
list.all
list.delete(3)
list.all

# SHOULD CREATE AN UNTITLED LIST AND ADD ITEMS TO IT
# --------------------------------------------------
new_list = UdaciList.new # Should create a list called "Untitled List"
new_list.add("todo", "Buy more dog food", due: "in 5 weeks", priority: "medium")
new_list.add("todo", "Go dancing", due: "in 2 hours")
new_list.add("todo", "Buy groceries", priority: "high")
new_list.add("event", "Birthday Party", start_date: "May 31")
new_list.add("event", "Vacation", start_date: "Dec 20", end_date: "Dec 30")
new_list.add("event", "Life happens")
new_list.add("link", "https://www.udacity.com/", site_name: "Udacity Homepage")
new_list.add("link", "http://ruby-doc.org")

# SHOULD RETURN ERROR MESSAGES
# ----------------------------
# new_list.add("image", "http://ruby-doc.org") # Throws InvalidItemType error
# new_list.delete(9) # Throws an IndexExceedsListSize error
# new_list.add("todo", "Hack some portals", priority: "super high") # throws an InvalidPriorityValue error

# DISPLAY UNTITLED LIST
# ---------------------
new_list.all

# DEMO FILTER BY ITEM TYPE
# ------------------------
puts new_list.filter("event")


# User input here
cli = HighLine.new
answer = cli.ask "Do you want to have your own UdaciList? (yes/no)"
if answer.start_with? "y"
  user_list = UdaciList.new(title: "Your Stuff")
  puts "You can add three kind of item: event, link, todo."
  puts "Format is shown below\n"
  puts "event|description here|start date here|end date here"
  puts "link|url here|sitename here"
  puts "todo|description here|due date here|priority here (high, medium, low supported)"
  puts "\nif you have accomplished, type end"
  while true
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
  user_list.all
end

