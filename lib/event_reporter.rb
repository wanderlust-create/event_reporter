require 'csv'
require 'pry'
class EventReporter
  attr_reader :data
  attr_accessor :queue, :clean_queue, :print_data

  def initialize
    # @data = CSV.read file, headers: true, header_converters: :symbol
    @queue = []
  end

  def load(file = 'full_event_attendees.csv')
    @data = CSV.read file, headers: true, header_converters: :symbol
    @queue.clear
  end

  def clear
    @queue.clear
  end

  def data_search(attribute, criteria)
    data.select do |row|
      queue << row if row[attribute.to_sym].to_s.downcase == criteria.downcase
    end
  end

  def zipcode(attribute, criteria)
    data.select do |row|
      queue << row if row[:zipcode].to_s.rjust(5, "0")[0..4] == criteria
    end
  end

  def find(attribute, criteria)
    if attribute == 'zipcode'
      zipcode(attribute, criteria)
      else data_search(attribute, criteria)
    # else
    #   "Invalid search parameter"
    end
    # data.rewind
    queue
  end

  def count
    queue.count
  end

  def save_to(filename = "queue.csv")
    CSV.open(filename, "wb") do |csv|
      csv << ['LAST NAME', 'FIRST NAME','EMAIL','ZIPCODE','CITY','STATE','ADDRESS','PHONE']
      csv << @queue.each do |row|
      csv << row.values_at(3, 2, 4, 9, 7, 8, 6, 5)
    end
    end
  end

  def print_to(filename = "queue.csv")
    CSV.foreach(filename) do |row|
      print "#{row.join(', ')}\n"
    end
  end

  def sort_by(attribute, filename = "queue.csv")
    save_to(filename)
    table = CSV.read(filename, headers: true)
    table.sort_by do |row|
      row[attribute.to_sym]
    end
  end

  def print_by(attribute, filename = "queue.csv")
    sort_by(attribute)
    print_to(filename)
  end

  def save_by(attribute, filename = "queue.csv")
    sort_by(attribute)
  end

  def help
    puts %q{
      Here is a list of the commands avaliable for you to use:

      find: this command will search for specific attributes in the CSV file
        then add the entire row of information from your results to your queue.

      count: this command will count the number of rows saved in your queue.

      load: this command will delete your current queue and you will
        start with a freah file.

      help + command will give you more specific instructions on how to
        use one of the above commands.
     }
  end
end



event = EventReporter.new
# binding.pry
# @queue << row if row[attribute.downcase.to_sym]  == criteria
# CSV.foreach(filename) do |row|
#   puts row
# end
p

# first_name = @data.row[:first_name].strip.downcase
#
#
# last_name = @data.row[:last_name].downcase
# email = @data.row[:email_address]
# phone = @data.row[:home_phone]
# zipcode = @data.row[:zipcode].rjust(5, "0")[0..4]
# city = @data.row[:city].capitalize
# state = @data.row[:state]
# address = @data.row[:address]

# def sory_by(attribute, filename = "queue.csv")
#   save_to(filename)
#   table = CSV.read(filename, headers: true).map { |row| Hash[row] }
#   table.sort_by { |k, _| [k["attribute,], k["price"].to_f, Date.parse(k["date"])] }
# end

# def clean_zipcode
#   clean_zip = []
#   @queue.each do |row|
#   clean_zip << row[zipcode].to_s.rjust(5,"0")[0..4]
#   end
#   return clean_zip
# end
# def first_name(attribute, criteria)
#   @data.select do |row|
#     @queue << row if row[attribute.to_sym].to_s.strip.downcase == criteria.downcase
#   end
# end
#
# def last_name(attribute, criteria)
#   @data.select do |row|
#     @queue << row if row[attribute.to_sym].to_s.strip.downcase == criteria.downcase
#   end
# end

# File.open(filename, "w") {|f| f.write(queue.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}
# clean_queue << row[:last_name].capitalize + row[:first_name].capitalize + row[:email_address] + row[:zipcode].to_s.rjust(5, "0")[0..4] + row[:city].capitalize + row[:state].upcase + row[:street] + row[:homephone]

# def select
#   queue.each do |row|
#   clean_queue << row.values_at(3, 2, 4, 9, 7, 8, 6, 5)
#   end
#   return clean_queue
# end
#
# def join
#   clean_queue.each do |row|
#     print_data << row.join(',') << "\n"
#   end
#   return print_data
# end

# def print
#   queue.each row do
#     last_name = row[:last_name]
#     first_name = row[:first_name]
#     email = row[:email_address]
#     zipcode = row[:zipcode].rjust(5, "0")[0..4]
#     city = row[:city].capitalize
#     state = row[:state]
#     address = row[:address]
#     phone = row[:home_phone]
