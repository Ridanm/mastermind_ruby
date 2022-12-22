# Estrategia para Mastermind: https://puzzling.stackexchange.com/questions/546/clever-ways-to-solve-mastermind

# Crear el juego de mastermind desde la línea de comandos en el 
# cual tienes 12 turnos para adivinar el código secreto 
# comenzando por adivinar el código aleatorio de la computadora

=begin   
  ¡Piensa en cómo plantearías este problema!
  Cree el juego asumiendo que la computadora selecciona aleatoriamente 
  los colores secretos y que el jugador humano debe adivinarlos. 
  ¡Recuerde que debe dar la retroalimentación adecuada sobre qué tan 
  buena fue la suposición en cada turno!
  Ahora refactorice su código para permitir que el jugador humano 
  elija si quiere ser el creador del código secreto o el adivinador.
  Constrúyelo para que la computadora adivine si decides elegir tus 
  propios colores secretos. Puede elegir implementar una estrategia 
  de computadora que siga las reglas del juego o puede modificar estas reglas.
  Si elige modificar las reglas, puede proporcionar a la computadora 
  información adicional sobre cada suposición. Por ejemplo, puede 
  comenzar haciendo que la computadora adivine al azar, pero mantenga 
  las que coincidan exactamente. Puede agregar un poco más de inteligencia 
  al reproductor de la computadora para que, si la computadora ha adivinado 
  el color correcto pero en la posición incorrecta, su siguiente intento 
  tendrá que incluir ese color en alguna parte.
  Si desea seguir las reglas del juego, deberá investigar estrategias para 
  resolver Mastermind, como esta publicación .
  ¡Publica tu solución a continuación!
=end

require 'rubocop'
require 'colorize'
module Intro
  WELCOME =  '--- Welcome to Mastermind ---'
end

class Computer
  
end

# Colores y clavijas
# 192 clavijas grandes de diferentes colores (Rojas, azules, verdes,
# amarillas, rosas, blancas, negras y marrones).
# • 60 espigas blancas y negras para la clave.
# • 4 espigas de tanteo, 2 rojas y 2 azules.
# Por cada clavija acertada en color y posición, colocará una espiga negra,
# y por cada color acertado pero en un lugar equivocado colocara una espiga
# blanca.

welcome = ' WELCOME TO MASTERMIND '
def msj(text)
  lines = '-' * text.size 
  "#{lines}\n#{text}\n#{lines}"
end
puts msj(welcome)

# 192 clavijas de los colores a elejir
puts 'Select the number for the color: '
  red = '  1  '.colorize(:color => :white, :background => :red)
  blue = '  2  '.colorize(:color => :white, :background => :blue)
  green = '  3  '.colorize(:color => :black, :background => :green)
  yellow = '  4  '.colorize(:color => :black, :background => :yellow)
  magenta = '  5  '.colorize(:color => :white, :background => :light_magenta)
  cyan = '  6  '.colorize(:color => :black, :background => :light_cyan)


colors = [red, blue, green, yellow, magenta, cyan]

def show_colors(color)
  puts color.join(' ')
end
show_colors(colors)

# 60 espigas blancas y negras
puts 'Espigas: '
white_spike = 'O'.colorize(:color => :white)
black_spike = 'O'.colorize(:color => :light_black)
spikes_white_black = [white_spike, black_spike]
puts spikes_white_black.join(' ')

# 4 espigas de tanteo 2 rojas y 2 azules
red_spike = 'O'.colorize(:color => :red)
blue_spike = 'O'.colorize(:color => :blue)
spikes_red_blue = [red_spike, blue_spike]
puts spikes_red_blue.join(' ')

# En inicio la computadora selecciona aleatoriamente los 4 colores secretos
puts 'Iniciando el juego la computadora: '
#comp_select_colors = colors.sample
rand_colors = []
4.times do |num|
  #puts comp_select_colors = colors.sample
  comp_select_colors = colors.sample
  rand_colors.push(comp_select_colors)
end

# El jugador humano tiene 12 turnos para adivinar
puts 'Adivina el código secreto de 4 colores generado por la computadora.'
puts 'Tienes 12 turnos para lograr descifrar el código de los colores.'
puts 'Ingrese 4 números del 1 al 6 cada número corresponde a un color.'
#puts rand_colors
p colores_prueba = ['1', '3', '6', '2']

# Ingresando código a verificar y restando turnos 
turnos = 2
while turnos > 0
  puts 'Ingrese el código: '
  guess = gets.chomp

  if guess.size == 4
    puts "good job"
    codigo_ingresado = guess.split('')

    codigo_ingresado.each_with_index do |num, ind|
    # Por cada turno debe recibir retroalimentoción de lo supocición de colores
    # comprobar si el número y el índice coinciden
      if num == colores_prueba[ind] 
        puts "El color #{ind} es correcto"
        # comprobar si el color está lo que en el lugar incorrecto
      elsif colores_prueba.include?(num)
        puts "El color #{num} está en el lugar incorrecto !!!"
      else
        puts "El color #{ind} es incorrecto"
      end
    end
  else
    puts 'El número de los colores es del 1 al 6 .'
    puts 'Debe ser un númro de 4 dígitos un número por cada color.'
  end
  turnos -= 1
end

# Refactorizar el código para que el jugador decida si quiere adivinar o elejir 
# el código secreto de colores 
# si el humano elige los colores el computador debe ser capaz de adivinar, si 
# Si elige modificar las reglas, puede proporcionar a la computadora información
# adicional sobre cada suposición. Por ejemplo, puede comenzar haciendo que la 
# computadora adivine al azar, pero mantenga las que coincidan exactamente. 
# Puede agregar un poco más de inteligencia al reproductor de la computadora 
# para que, si la computadora ha adivinado el color correcto pero en la posición 
# incorrecta, su siguiente intento tendrá que incluir ese color en alguna parte. 

