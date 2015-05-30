require_relative "word_stem"

class WordList
  def initialize(input_filename)

    @root_stems = Array.new(26) {|index|
      WordStem.new
    }

    File.open(input_filename).each do |word|
      add(word)
    end
  end

  def contains?(stem)

  end

  private

  def add(word)
    root_index = WordStem.letter_index(word.chr)
    @root_stems[root_index].build_out(word)
  end

end
