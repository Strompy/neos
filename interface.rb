require_relative 'near_earth_objects'

class Interface
  def self.start
    greeting
    @@date = gets.chomp
    @@neos = NearEarthObjects.new(@@date)
    @@asteroids_details = @@neos.neos_data
    output
  end

  def self.greeting
    puts "________________________________________________________________________________________________________________________________"
    puts "Welcome to NEO. Here you will find information about how many meteors, asteroids, comets pass by the earth every day.
      \nEnter a date below to get a list of the objects that have passed by the earth on that day."
    puts "Please enter a date in the following format YYYY-MM-DD."
    print ">>"
  end

  def self.asteroid_list
    @@asteroids_details[:asteroid_list]
  end

  def self.total_number_of_asteroids
    @@asteroids_details[:total_number_of_asteroids]
  end

  def self.biggest_asteroid
    @@asteroids_details[:biggest_asteroid]
  end

  def self.column_labels
    { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
  end

  def self.column_data
    column_labels.each_with_object({}) do |(col, label), hash|
      hash[col] = {
        label: label,
        width: [asteroid_list.map { |asteroid| asteroid[col].size }.max, label.size].max}
    end
  end

  def self.header
    "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
  end

  def self.divider
    "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
  end

  def self.format_row_data(row_data, column_info)
    row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
    puts "| #{row} |"
  end

  def self.create_rows(asteroid_data, column_info)
    rows = asteroid_data.each { |asteroid| format_row_data(asteroid, column_info) }
  end

  def self.format_date
    DateTime.parse(@@date).strftime("%A %b %d, %Y")
  end

  def self.output
    puts "______________________________________________________________________________"
    puts "On #{format_date}, there were #{total_number_of_asteroids} objects that almost collided with the earth."
    puts "The largest of these was #{biggest_asteroid} ft. in diameter."
    puts "\nHere is a list of objects with details:"
    puts divider
    puts header
    create_rows(asteroid_list, column_data)
    puts divider
  end

end
