# Pasa cada elemento de la colección al bloque dado. 
# El método devuelve verdadero si el bloque nunca devuelve falso o nulo. 
# Si el bloque no es dado, Ruby agrega un bloque implícito de { |obj| obj } 
# que causará todos? para devolver verdadero cuando ninguno de los miembros
# de la colección son falsos o nulos .
# Si, en cambio, se proporciona un patrón, el método devuelve
# si el patrón === elemento para cada miembro de la colección. 

# %w[ant bear cat].all? { |word| word.length >= 3 } #=> true
# %w[ant bear cat].all? { |word| word.length >= 4 } #=> false
# %w[ant bear cat].all?(/t/)                        #=> false
# [1, 2i, 3.14].all?(Numeric)                       #=> true
# [nil, true, 99].all?                              #=> false
# [].all?                                           #=> true

# arr = [1, 2, 3, 6, 7]

# enter_colors = Array.new

# puts 'Ingrese los 4 colores'
# ingrese_colores = gets.chomp

# ingrese_colores.split('').each do |elem|
#   enter_colors << elem
# end

# if enter_colors.length == 4
#   comp = enter_colors.all? do |elem|
#   elem.to_i.between?(1, 6)
# end
# else
#   comp = 'Enter 4 colors please'
# end
# puts "Comp: #{comp}"


# name = "Robert"
# age = 23
# clima = "sunny"
# separando = [name, age, clima] 
# p separando[1]

# Algoritmo para cambiar los colores en un array cuyo valor es comparado con otro 
# Basados en la comparación de lo que devuelve el feedback 
puts 'A comparar '
a_comparar = [1, 2, 3, 4]

adivinando = [2, 3, 1, 4]

feedback = [false, false, false, true]

class Compare 
# Debemos tener un caso base para comparar(cuidado con agregar más colores al correct_colors)
# Crear un array para guardor los colores que sean correctos
# Hacer una copia del array correcto para trabajar con ella 
#  basado en el feedback 

def initialize 
  @correct_colors = Array.new 
end

  def comparar(guess, feedback)
    resultado = Array.new 
    anterior = adiv 
    actual = feedback 

    adiv.each_with_index do |col, ind|
      
    end
  end

end

# .1 Basado en el feedback debemos verificar los colores elegidos por el computador
# .2 Si el índice y el color coinciden el color debe permanecer en dicho lugar 
# .3 Si el color está en el índice incorrecto mantener el color y cambiarlo de índice
# .4 Se el índice no tiene color cambiarlo por uno al azar
# .5 retornar el nuevo array para compararlo usar winner para verificar ganador 

# NOTA 
# La clase feedback retorna o.colorize 
# debemos recibir lo que elegió el computador para variar sus colores


puts '----------------------------------------'

# comprobar rectificar esta función debe ejecutar la parte correspondiente al computador
# La cual se encuentra en la clase main de refactor mastermind
puts 'Función desarrollo del juego del computador: '

puts 'Procs -------------------------------------'
guardar = []

algo = Proc.new{ |(c, d)| "#{guardar << c} #{guardar << d}"}
 
algo.call([2, 22 ,3]) 

p guardar

contar_element = [1, 2, 3, 4, 5, 5, 5, 'a', 'a']

print "\ncontar_element: "
p contar_element
puts "count method: #{contar_element.count}"
puts "count method(1) #{contar_element.count(1)}"
puts "count method(5) #{contar_element.count(5)}"
puts "count method('a') #{contar_element.count('a')}"

llaves = {
  '1' => '1',
  '2' => '2',
  '3' => '3'
}

a_symbol = llaves['1'].to_sym
puts a_symbol
puts a_symbol.class 