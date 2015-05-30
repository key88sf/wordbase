class WordStem

  def initialize
    @leaves = nil
    @terminal = false
  end

  def build_out(remaining_stem)
    if remaining_stem.length == 1
      @terminal = true
    else
      @leaves ||= Hash.new

      next_letter = remaining_stem.chr
      leaf_node = @leaves[next_letter] || WordStem.new
      leaf_node.build_out(remaining_stem.slice(1, remaining_stem.length))
      @leaves[next_letter] = leaf_node
    end

  end

  def self.letter_index(letter)
    letter.downcase!
    letter.codepoints[0] - 97 # ASCII value of 'a'
  end

end