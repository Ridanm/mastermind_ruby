class Hint

  def initialize(player, compare)
    @player = player
    @compare = compare
  end

  def feedback_colors(to_compare, compare)
    back = Array.new 

    compare.each_with_index do|data, ind| 
      if data == to_compare[ind]
        back << ColorsMarks::Mark['black']
      elsif to_compare.include?(data)
        back << ColorsMarks::Mark['white']
      else 
        back << '   '
      end
    end
    back 
  end

end