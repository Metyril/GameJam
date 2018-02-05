require 'gosu'

require_relative 'Dungeon/Map.rb'
require_relative 'Dungeon/Player.rb'
require_relative 'Dungeon/Element.rb'
require_relative 'Dungeon/Ennemi.rb'

require_relative 'Omotecy/createModele.rb'
require_relative 'Omotecy/projectModele.rb'

WIDTH = 1000
HEIGHT = 600

##$WIDTH = 1600
##$HEIGHT = 900

DEMIPI = Math::PI/2

class Fenetre < Gosu::Window
  def initialize
    super WIDTH, HEIGHT

    Triangle.setRefSize(WIDTH, HEIGHT)

    @map_width = 30         # Largeur de la Map
    @map_height = 30        # Hauteur de la Map
    @cell_size = 20         # Taille d'une cellule
    @wall_size = 5          # Largeur d'un mur
    @nb_room = 3            # Nombre de salles
    @type_gen = 'random'    # Type de génération / 4 valeurs possibles : 'random', 'newest', 'middle', 'oldest'

    @map = Map.new(@map_width, @map_height, @cell_size, @wall_size, @nb_room, @type_gen)   # Map à générer

    @player = Player.new(@map)
    @playerModele = CreateModele::player

    @ennemis = Array.new
    @ennemisModele = Array.new
   for i in 0..4
        @ennemis << Ennemi.new(@map)
        @ennemisModele << CreateModele::player(true)
    end

    @camera = Camera.new

    @listeModeleCellules = Array.new
    for i in (0..15)
      @listeModeleCellules.push(CreateModele::cellule(i.to_s(2).rjust(4, '0')))
      #@listeModeleCellules.push(CreateModele::cellule("0111"))
    end
  end

  def update
    self.caption = "#{Gosu.fps} FPS / x:#{@camera.position.x.round} y:#{@camera.position.y.round} z:#{@camera.position.z.round}"

    #angle = 0
    #dist = 0
    #if @focus
    #  angle = -Math.atan2($MOUSEREFX - cursor_position[0],  $MOUSEREFY - cursor_position[1])
    #  dist = Math.sqrt(($MOUSEREFX - cursor_position[0])**2 + ($MOUSEREFY - cursor_position[1])**2) * 0.005
    #  mouse_move($MOUSEREFX, $MOUSEREFY)
    #end

    frontal = 0
    lateral = 0

    frontal = -1 if Gosu.button_down? Gosu::KB_S
    frontal = 1 if Gosu.button_down? Gosu::KB_W
    lateral = -1 if Gosu.button_down? Gosu::KB_A
    lateral = 1 if Gosu.button_down? Gosu::KB_D

    @camera.position.y -= 0.2 if Gosu.button_down? Gosu::KB_E or Gosu.button_down? Gosu::KB_SPACE
    @camera.position.y += 0.2 if Gosu.button_down? Gosu::KB_Q or Gosu.button_down? Gosu::KB_LEFT_CONTROL

    @camera.rotation.x -= 0.02 if Gosu.button_down? Gosu::KB_UP
    @camera.rotation.x += 0.02 if Gosu.button_down? Gosu::KB_DOWN
    @camera.rotation.y -= 0.02 if Gosu.button_down? Gosu::KB_LEFT
    @camera.rotation.y += 0.02 if Gosu.button_down? Gosu::KB_RIGHT

    @camera.position.x += Math.sin(@camera.rotation.y) * frontal + Math.cos(-@camera.rotation.y) * lateral
    @camera.position.z += Math.cos(@camera.rotation.y) * frontal + Math.sin(-@camera.rotation.y) * lateral

    #@camera.rotation.x += Math.cos(angle) * dist
    #@camera.rotation.y += Math.sin(angle) * dist

    if @camera.rotation.x > DEMIPI
      @camera.rotation.x = DEMIPI
    elsif @camera.rotation.x < -DEMIPI
      @camera.rotation.x = -DEMIPI
    end
  end

  def draw
    # self.drawMapClip
    self.drawMapTotal
    @playerModele.draw(@camera, @player.x, 0, @player.z, 0, 0, 0)
    for i in 0..4
      @ennemisModele[i].draw(@camera, @ennemis[i].x, 0, @ennemis[i].z, 0, 0, 0)
    end
    Gosu::draw_rect(0, 0, WIDTH, HEIGHT, 0xff2c3e50, -10000)
    #@map.draw
  end

  def drawMapClip
    cibleX = @camera.position.x
    cibleZ = @camera.position.z
    size = 10 * 20

    z = 0
    x = 0

    @map.map.reverse_each do |row|
      row.each do |cel|
        if cel != 0
          if (x >= cibleX - size && x <= cibleX + size) && (z >= cibleZ - size && z <= cibleZ + size)
            @listeModeleCellules[cel].draw(@camera, x, 0, z, 0, 0, 0)
            # if @player.x == x && @player.y == z
            #   @playerModele.draw(@camera, @player.x, 0, @player.y, 0, 0, 0)
            # end
            # for i in 0..4
            #   if @ennemis[i].x == x && @ennemis[i].y == z
            #     @ennemisModele[i].draw(@camera, @ennemis[i].x, 0, @ennemis[i].y, 0, 0, 0)
            #   end
            # end
          end
        end
        x += 20
      end
      z += 20
      x = 0
    end
  end

  def drawMapTotal
    z = 0
    x = 0

    @map.map.reverse.each do |row|
      row.each do |cel|
        if cel != 0
          @listeModeleCellules[cel].draw(@camera, x, 0, z, 0, 0, 0)
        end
        x += 20
      end
      z += 20
      x = 0
    end
  end
end

Fenetre.new.show
