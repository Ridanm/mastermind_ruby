class Computer < Player

  attr_reader :colors, :computer_colors
  include ColorsMarks 

  def initialize
    @computer_colors = Array.new
  end

  def enter_colors!(colors = '')
    computer_colors = Array.new 
    if colors == ''
      first_guess_color!.each {|col| computer_colors << col}
    else
      colors.each do |col|
        computer_colors << col
      end
    end
    computer_colors
  end

  def first_guess_color!
    computer_secret_code = Array.new
    first_guess = ''

    4.times { first_guess << rand(1..6).to_s } 
    first_guess.split('').each { |val| computer_secret_code << val }
    computer_secret_code
  end

  def feedback(codigo_azar, codigo_secreto)
    white = Array.new(4) {''}
    black = Array.new(4) {''}
  
    codigo_azar.each_with_index do |code, ind|
        if code == codigo_secreto[ind]
          black[ind] << code
        elsif codigo_secreto.include?(code)
          white[ind] << "it's include"
        elsif code != codigo_secreto[ind]
          white[ind] << "not include"
        end
      end
  
    return white, black
  end 

  def order_colors(white_arr, black_arr, guess)
    sort_colors = black_arr 
    all_elements = (1..6).to_a 
    posibles_numeros = guess 
  
    if black_arr.include?('') 
      sort_colors.each_with_index do |elem, ind|
        if elem == ''
          white_arr.each_with_index do |white_elem, pos|
            if white_elem == 'include' 
              sort_colors << posibles_numeros[ind] 
            elsif white_elem == 'not include'
              add_new_num =  all_elements.sample.to_s 
              sort_colors[ind] = add_new_num
            elsif white_elem == ''
              add_num = all_elements.sample.to_s 
              sort_colors[ind] = add_num
            end
          end
        end
      end
    end
    sort_colors
  end

end