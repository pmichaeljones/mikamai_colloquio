class StudioGhibliScraper 

  require 'open-uri'
  require 'json'

  # I Would love to learn more about executing faster code on API calls, as well as best practices. 
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
  def self.execution_speed
    time_1 = Time.now
    yield
    time_2 = Time.now
    execution_speed = time_2 - time_1
    puts "---"
    puts "The above scrape was completed in #{execution_speed} seconds."
    puts ""
  end
end

scraper = StudioGhibliScraper.new

Timer.execution_speed do 
  scraper.print_human_names_to_console
end

Timer.execution_speed do 
  scraper.return_human_names_in_array
end

Timer.execution_speed do 
  scraper.return_array_of_human_hashes
end