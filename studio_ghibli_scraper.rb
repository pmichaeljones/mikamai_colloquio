class StudioGhibliScraper 

  require 'open-uri'
  require 'json'

  # I would love to learn more about executing faster code on API calls, as well as best practices. 
  # I've always been fascinated with API consumption and API production.

  def print_human_names_to_console
    people = JSON.parse(open("https://ghibliapi.herokuapp.com/people/").read)
    puts "Here are all the 'Ghibli People' that are Human:"
    people.each do |person|
      puts person["name"] if person["species"] == "https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"
    end
    nil
  end

  def return_human_names_in_array
    humans = []
    people = JSON.parse(open("https://ghibliapi.herokuapp.com/people/").read)
    people.each do |person|
      humans << person["name"] if person["species"] == "https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"
    end
    print humans
    puts ""
  end

  def return_array_of_human_hashes
    humans = []
    people = JSON.parse(open("https://ghibliapi.herokuapp.com/people/").read)
    people.each do |person|
      humans << person if person["species"] == "https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"
    end
    print humans
  end

end

class Timer
  def self.execution_speed(name)
    time_1 = Time.now
    yield
    time_2 = Time.now
    execution_speed = time_2 - time_1
    puts "---"
    puts "#{name}: Completed in #{execution_speed} seconds."
    puts ""
    execution_speed
  end
end

puts "Starting CURL to set a benchmark speed..."

timer1 = Timer.execution_speed("Curl") do 
  system "curl 'https://ghibliapi.herokuapp.com/people/'"
end

puts "---"

scraper = StudioGhibliScraper.new

timer2 = Timer.execution_speed("Printing to console") do 
  scraper.print_human_names_to_console
end

timer3 = Timer.execution_speed("Returning human name array") do 
  scraper.return_human_names_in_array
end

timer4 = Timer.execution_speed("Returning full data hashes") do 
  scraper.return_array_of_human_hashes
end

puts %Q{
Here's the Execution Speed Outcome:
Curl: #{timer1}
Printing to Console: #{timer2}
Returning Names Array: #{timer3}
Returning Full Data Hash: #{timer4}

}


