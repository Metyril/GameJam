require 'gosu'

require_relative 'Dungeon/Map.rb'
require_relative 'Dungeon/Player.rb'
require_relative 'Dungeon/Element.rb'
require_relative 'Dungeon/Ennemi.rb'
require_relative 'Dungeon/ObjetRamassable.rb'

require_relative 'Omotecy/createModele.rb'
require_relative 'Omotecy/projectModele.rb'

require_relative 'Dungeon/MurHitBox.rb'

WIDTH = 1280
HEIGHT = 720

DEMIPI = Math::PI/2

class Fenetre < Gosu::Window
  def initialize
    super WIDTH, HEIGHT, option = {fullscreen: false}

    Triangle.setRefSize(WIDTH, HEIGHT)

    @map_width = 30         # Largeur de la Map
    @map_height = 30        # Hauteur de la Map
    @cell_size = 20         # Taille d'une cellule
    @wall_size = 5          # Largeur d'un mur
    @nb_room = 3            # Nombre de salles
    @type_gen = 'random'    # Type de génération / 4 valeurs possibles : 'random', 'newest', 'middle', 'oldest'

    @map = Map.new(@map_width, @map_height, @cell_size, @wall_size, @nb_room, @type_gen)   # Map à générer

    @playerModele = CreateModele::player
    @player = Player.new(@map, @playerModele)


    @ennemis = Array.new
    ennemisModele = CreateModele::player(true)
    for i in 0..4
      @ennemis << Ennemi.new(@map, ennemisModele)
    end

    modeleruby = CreateModele::ruby
    @ramassables = Array.new
    for i in 1..20
      @ramassables << ObjetRamassable.new(@map, modeleruby)
    end

    @camera = Camera.new(@player.x, @player.y,@player.z-30)
    @batte = CreateModele::batte
    @ruby = CreateModele::ruby

    @listeModeleCellules = Array.new
    for i in (0..15)
      @listeModeleCellules.push(CreateModele::cellule(i.to_s(2).rjust(4, '0'), 0))
      #@listeModeleCellules.push(CreateModele::cellule("0111"))
    end

    #               SUD                         NORD                           EST                           OUEST
    @mursHitBox = [MurHitBox.new("S"), MurHitBox.new("N"), MurHitBox.new(@cell_size), MurHitBox.new(@cell_size)]
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def rotation()
      @cameraBase = Camera.new(0,0,-30)
      self.rotateX()
      self.rotateY()
      self.rotateZ()
      @camera.position.x = @cameraBase.position.x + @player.x
      @camera.position.y = @cameraBase.position.y + @player.y
      @camera.position.z = @cameraBase.position.z + @player.z
  end

  def rotateZ()
    @cameraBase.position.x = @cameraBase.position.x*Math.cos(@camera.rotation.z) - @cameraBase.position.y*Math.sin(@camera.rotation.z)
    @cameraBase.position.y = @cameraBase.position.y*Math.cos(@camera.rotation.z) + @cameraBase.position.x*Math.sin(@camera.rotation.z)
  end

  def rotateY()
    @cameraBase.position.x = @cameraBase.position.x*Math.cos(@camera.rotation.y) - @cameraBase.position.z*Math.sin(@camera.rotation.y)
    @cameraBase.position.z = @cameraBase.position.z*Math.cos(@camera.rotation.y) + @cameraBase.position.x*Math.sin(@camera.rotation.y)
  end

  def rotateX()
    @cameraBase.position.y = @cameraBase.position.y*Math.cos(@camera.rotation.x) - @cameraBase.position.z*Math.sin(@camera.rotation.x)
    @cameraBase.position.z = @cameraBase.position.z*Math.cos(@camera.rotation.x) + @cameraBase.position.y*Math.sin(@camera.rotation.x)
  end

  def update
    self.caption = "#{Gosu.fps} FPS / x:#{@camera.position.x.round} y:#{@camera.position.y.round} z:#{@camera.position.z.round} | Px:#{@player.getCelX} Pz:#{@player.getCelZ} PVal:#{@player.getCelVal}"

    #angle = 0
    #dist = 0
    #if @focus
    #  angle = -Math.atan2($MOUSEREFX - cursor_position[0],  $MOUSEREFY - cursor_position[1])
    #  dist = Math.sqrt(($MOUSEREFX - cursor_position[0])**2 + ($MOUSEREFY - cursor_position[1])**2) * 0.005
    #  mouse_move($MOUSEREFX, $MOUSEREFY)
    #end

#########################################################""""""""""""

  #  frontal = 0
  #  lateral = 0

    #frontal = -1 if Gosu.button_down? Gosu::KB_K
    #frontal = 1 if Gosu.button_down? Gosu::KB_I
    #lateral = -1 if Gosu.button_down? Gosu::KB_J
    #lateral = 1 if Gosu.button_down? Gosu::KB_L
    #@camera.position.y -= 0.2 if Gosu.button_down? Gosu::KB_E or Gosu.button_down? Gosu::KB_SPACE
    #@camera.position.y += 0.2 if Gosu.button_down? Gosu::KB_Q or Gosu.button_down? Gosu::KB_LEFT_CONTROL

    #if Gosu.button_down? Gosu::KB_UP
  #    @camera.rotation.x -= 0.02
  #    self.rotation()
    #end

    #if Gosu.button_down? Gosu::KB_DOWN
    #  @camera.rotation.x += 0.02
    #  self.rotation()
    #end
    #if Gosu.button_down? Gosu::KB_LEFT
    #  @camera.rotation.y += 0.02
    #  @player.changementAngle(@camera.rotation.y)
    #  @camera.position.x = (30*Math.sin(-@camera.rotation.y)) + @player.x
    #  @camera.position.z = (-30*Math.cos(@camera.rotation.y)) + @player.z
  #  end
    #if Gosu.button_down? Gosu::KB_RIGHT
    #  @camera.rotation.y -= 0.02
    #  @player.changementAngle(@camera.rotation.y)
    #  @camera.position.x = (30*Math.sin(-@camera.rotation.y)) + @player.x
    #  @camera.position.z = (-30*Math.cos(@camera.rotation.y)) + @player.z
    #end


    #if Gosu.button_down? Gosu::KB_W
    #  @player.deplacement("Z")
    #  @camera.position.x += Math.sin(@camera.rotation.y)* @player.vitesse
    #  @camera.position.z +=  Math.cos(-@camera.rotation.y)* @player.vitesse
    #end
    #if Gosu.button_down? Gosu::KB_S
    #  @player.deplacement("S")

    #  @camera.position.x -= Math.sin(@camera.rotation.y)* @player.vitesse
    #  @camera.position.z -= Math.cos(-@camera.rotation.y)* @player.vitesse
    #end
    #if Gosu.button_down? Gosu::KB_D
    #    @player.deplacement("D")

    #    @camera.position.x += Math.cos(@camera.rotation.y)* @player.vitesse
    #    @camera.position.z += Math.sin(-@camera.rotation.y)* @player.vitesse
    #end
    #if Gosu.button_down? Gosu::KB_A
    #  @player.deplacement("Q")

    #  @camera.position.x -= Math.cos(@camera.rotation.y)* @player.vitesse
    #  @camera.position.z -= Math.sin(-@camera.rotation.y)* @player.vitesse
    #end

####################################"""""""""""""""

  frontal = 0
  lateral = 0

  frontal = -0.4 if Gosu.button_down? Gosu::KB_S
  frontal = 0.4 if Gosu.button_down? Gosu::KB_W
  lateral = -0.4 if Gosu.button_down? Gosu::KB_A
  lateral = 0.4 if Gosu.button_down? Gosu::KB_D

  @player.angle += -0.1 if Gosu.button_down? Gosu::KB_LEFT
  @player.angle += 0.1 if Gosu.button_down? Gosu::KB_RIGHT

  @player.x += Math.sin(@player.angle) * frontal + Math.cos(-@player.angle) * lateral
  @player.z += Math.cos(@player.angle) * frontal + Math.sin(-@player.angle) * lateral

  @camera.position.x = @player.x
  @camera.position.z = @player.z - 40

  @camera.position.y = -20
  @camera.rotation.x = -0.5


    if @camera.rotation.x > DEMIPI
      @camera.rotation.x = DEMIPI
    elsif @camera.rotation.x < -DEMIPI
      @camera.rotation.x = -DEMIPI
    end



    #@camera.rotation.x += Math.cos(angle) * dist
    #@camera.rotation.y += Math.sin(angle) * dist


    #################################
    #update des objets

    @player.update
    self.murCollision @player


    @ramassables.each do |ramassable|
      ramassable.detruire if self.dist(@player, ramassable) < (@player.itBox + ramassable.itBox)
    end

    self.iter @ennemis
    self.iter @ramassables
  end

  def dist o1, o2
    return Math.sqrt((o2.x - o1.x)**2 + (o2.z - o1.z)**2)
  end

  def iter liste
    liste.delete_if do |elem|
      elem.update
      elem.isDetruit
    end
  end

  def murCollision cible
    val = cible.getCelVal
    if (val & S) == 0
      @mursHitBox[0].setPos(cible.getCelX*@cell_size, cible.getCelZ*@cell_size+(@cell_size/2))
      @mursHitBox[0].collision cible
    end

    if (val & N) == 0
      @mursHitBox[1].setPos(cible.getCelX*@cell_size, cible.getCelZ*@cell_size-(@cell_size/2))
      @mursHitBox[1].collision cible
    end
  end

  def draw
    #self.drawMapClip
    self.drawMapTotal
    #@playerModele.draw(@camera, @player.x, @player.y, @player.z, 0, -@player.angle, 0)

    @player.draw(@camera)

    @ennemis.each do |ennemi|
      #@ennemisModele.draw(@camera, ennemi.x, ennemi.y, ennemi.z, 0, 0, 0)
      ennemi.draw(@camera)
    end

    @ramassables.each do |ramassable|
      ramassable.draw(@camera)
    end

    @playerModele.draw(@camera, 0, 0, 0, 0, 0, 0)
    @batte.draw(@camera, @mursHitBox[0].x, 0, @mursHitBox[0].z, 0, 0, 0)
    @ruby.draw(@camera, @mursHitBox[1].x, 0, @mursHitBox[1].z, 0, 0, 0)
    Gosu::draw_rect(0, 0, WIDTH, HEIGHT, 0xff2c3e50, -10000)
    #@map.draw
  end

  def drawMapClip
    cibleX = @camera.position.x
    cibleZ = @camera.position.z
    size = 10 * 20

    z = 0
    x = 0

    #@map.map.reverse_each do |row|
    @map.map.each do |row|
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

    #@map.map.reverse.each do |row|
    @map.map.each do |row|
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
