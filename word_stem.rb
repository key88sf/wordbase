class WordStem

  def initialize(my_letter = "")
    @letter = my_letter
    @leaves = nil
    @terminal = false
  end

  attr_reader :terminal

  def build_out(remaining_stem)
    if remaining_stem.length == 0
      @terminal = true
      return
    end

    @leaves ||= Hash.new

    next_letter = remaining_stem.chr
    leaf_node = @leaves[next_letter] || WordStem.new(next_letter)
    leaf_node.build_out(remaining_stem.slice(1, remaining_stem.length))
    @leaves[next_letter] = leaf_node
  end

  def find(remaining_stem)
    return nil if @leaves.nil? # We have no more leaves to traverse so can't continue

    next_letter = remaining_stem.chr
    leaf_node = @leaves[next_letter]
    if leaf_node.nil?
      return nil
    elsif remaining_stem.length == 1
      return leaf_node
    else
      return leaf_node.find(remaining_stem.slice(1, remaining_stem.length))
    end

  end

end