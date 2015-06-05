require_relative "word_stem"

class WordList
  def initialize
    @root = WordStem.new
  end

  def build_from_file(input_filename)
    File.open(input_filename).each do |word|
      word.chomp!
      add(word.downcase)
    end
  end

  def add(word)
    @root.build_out(word)
  end

  def find(stem)
    @root.find(stem)
  end

end
