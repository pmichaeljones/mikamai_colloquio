class AnagramSolver

  require 'open-uri'
  require 'pry'

  attr_reader :words_array

  def initialize
    @words_array = []
    @sorted_words = []
  end

  def load_words
    words = open("http://codekata.com/data/wordlist.txt").read
    words.each_line do |word|
      @words_array << word.chomp.downcase.gsub(/'.*/, "")
    end
    @words_array.each do |word|
      @sorted_words << word.chars.sort.join
    end
  end

  def find_anagram(word)
    if @sorted_words.include?(word.gsub(/ /,'').chars.sort.join)
      puts word
    end
  end

end

solver = AnagramSolver.new

solver.load_words

binding.pry