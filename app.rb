require 'chronic'
require 'colorize'
require 'terminal-table'
require 'nokogiri'
require 'open-uri'
require 'ice_cube'
require 'icalendar'
# Find a third gem of your choice and add it to your project
require 'date'
require_relative "lib/listable"
require_relative "lib/recurrent"
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

#SHOULD CREATE AN UNTITLED LIST AND ADD ITEMS TO IT
#--------------------------------------------------
new_list = UdaciList.new # Should create a list called "Untitled List"
new_list.add("todo", "Buy more dog food", due: "in 5 weeks", priority: "medium")
new_list.add("todo", "Go dancing", due: "in 2 hours")
new_list.add("todo", "Buy groceries", priority: "high")
new_list.add("event", "Birthday Party", start_date: "May 31")
new_list.add("event", "Vacation", start_date: "Dec 20", end_date: "Dec 30")
new_list.add("event", "Life happens")
new_list.add("link", "https://www.udacity.com/", site_name: "Udacity Homepage")
new_list.add("link", "http://ruby-doc.org") # will pick title from internet

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
new_list.filter("event")




# DEMO for multiple Untitled Lists name
# ----------------------------
# title is Untitled List 2
new_list2 = UdaciList.new
new_list2.add("todo", "Ability to delete lists", priority: "medium")

new_list2.all

# DEMO for multiple Untitled Lists name
# ----------------------------
# title is Untitled List 3
new_list3 = UdaciList.new
new_list3.add("todo", "Ability to delete lists", priority: "medium")

new_list3.all




deepak_list = UdaciList.new(title: "Deepak's UdaciTask")

deepak_list.add("todo", "Complete Ruby Nanodegree", due: "in 3 weeks", priority: "high")
deepak_list.item_at_index(1).export_to_ics(deepak_list.title)

deepak_list.add("todo", "Go to sleep", due: "in 2 hours")
deepak_list.item_at_index(2).export_to_ics(deepak_list.title)

deepak_list.add("todo", "Buy groceries", priority: "high")
# DEMO InvalidICalendarObject for todo
# ----------------------------
# deepak_list.item_at_index(3).export_to_ics(deepak_list.title) # Throws InvalidICalendarObject error no due date

deepak_list.add("event", "My Birthday", start_date: "Apr 7", all_day: true)
deepak_list.item_at_index(4).recurrence(yearly: 1,month_of_year:4, day_of_month: 7)
deepak_list.item_at_index(4).export_to_ics(deepak_list.title)

# DEMO InvalidICalendarObject for event
# ----------------------------
# deepak_list.add("event", "Some Event")
# deepak_list.item_at_index(5).export_to_ics(deepak_list.title) # Throws InvalidICalendarObject error

deepak_list.add("todo", "Submit Phone Bill", due:"5th of april",priority: "low")
deepak_list.item_at_index(5).recurrence(monthly: 1, day_of_month: 5)
deepak_list.item_at_index(5).change_priority("medium")
deepak_list.item_at_index(5).export_to_ics(deepak_list.title)

deepak_list.add("todo","Go to movie Dawn of Justice", priority: "high", due: "today 7pm")
deepak_list.item_at_index(6).export_to_ics(deepak_list.title)

deepak_list.all
