require "pry"
require './lib/event_reporter.rb'

class ErUser

  def initialize
    @er_file = EventReporter.new
  end

  def start
    welcome_menu

    start_from = $stdin.gets.chomp

    help_or_find(start_from)
  end

  def welcome_menu
    print %q{
      "Welcome to the handy-dandy CSV file reader and sorter.

      Would you like to access the help menu first?

      Please choose 1 for Yes
      or choose 2 for No
      >>>>>"
      }
  end

  def help_or_find
    if start_from.to_i == 1 ; @er_file.help
    elsif start_from.to_i == 2 ; @er_file.load
    else p "Invalid input. Please select 1 or 2." ; help_or_find
  end
end

go = ErUser.new
binding.pry

p
end
