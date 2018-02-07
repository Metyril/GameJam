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

    @freeCam = false

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
    @batte = CreateModele::pilule
    @ruby = CreateModele::ruby

    @listeModeleCellules = Array.new
    for i in (0..15)
      @listeModeleCellules.push(CreateModele::cellule(i.to_s(2).rjust(4, '0'), 0))
      #@listeModeleCellules.push(CreateModele::cellule("0111"))
    end

    #               SUD                 NORD                EST                           OUEST
    @mursHitBox = [MurHitBox.new("S"), MurHitBox.new("N"), MurHitBox.new("E"), MurHitBox.new("W")]
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KB_TAB
      @freeCam = !@freeCam
    end
  end



  def update
    self.caption = "#{Gosu.fps} FPS / x:#{@camera.position.x.round} y:#{@camera.position.y.round} z:#{@camera.position.z.round} | Px:#{@player.getCelX} Pz:#{@player.getCelZ} PVal:#{@player.getCelVal}"

    frontal = 0
    lateral = 0
    frontal = -0.6 if Gosu.button_down? Gosu::KB_S
    frontal = 0.6 if Gosu.button_down? Gosu::KB_W
    lateral = -0.4 if Gosu.button_down? Gosu::KB_A
    lateral = 0.4 if Gosu.button_down? Gosu::KB_D
    @player.angle += -0.03 if Gosu.button_down? Gosu::KB_LEFT
    @player.angle += 0.03 if Gosu.button_down? Gosu::KB_RIGHT
    @player.x += Math.sin(@player.angle) * frontal + Math.cos(-@player.angle) * lateral
    @player.z += Math.cos(@player.angle) * frontal + Math.sin(-@player.angle) * lateral

    if !@freeCam
      @camera.position.x = -Math.sin(@player.angle) * 30 + @player.x
      @camera.position.z = -Math.cos(@player.angle) * 25 + @player.z

      @camera.rotation.y = @player.angle

      @camera.position.y = -35
      @camera.rotation.x = -0.9
    else
      frontalCam = 0
      lateralCam = 0
      frontalCam = -1 if Gosu.button_down? Gosu::KB_K
      frontalCam = 1 if Gosu.button_down? Gosu::KB_I
      lateralCam = -0.6 if Gosu.button_down? Gosu::KB_J
      lateralCam = 0.6 if Gosu.button_down? Gosu::KB_L

      @camera.position.y += -1 if Gosu.button_down? Gosu::KB_O
      @camera.position.y += 1 if Gosu.button_down? Gosu::KB_U
      @camera.position.x += Math.sin(@camera.rotation.y) * frontalCam + Math.cos(-@camera.rotation.y) * lateralCam
      @camera.position.z += Math.cos(@camera.rotation.y) * frontalCam + Math.sin(-@camera.rotation.y) * lateralCam

      @camera.rotation.x += -0.03 if Gosu.button_down? Gosu::KB_NUMPAD_8
      @camera.rotation.x += 0.03 if Gosu.button_down? Gosu::KB_NUMPAD_5
      @camera.rotation.y += -0.03 if Gosu.button_down? Gosu::KB_NUMPAD_4
      @camera.rotation.y += 0.03 if Gosu.button_down? Gosu::KB_NUMPAD_6
    end

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

    if (val & E) == 0
      @mursHitBox[2].setPos(cible.getCelX*@cell_size+(@cell_size/2), cible.getCelZ*@cell_size)
      @mursHitBox[2].collision cible
    end

    if (val & W) == 0
      @mursHitBox[3].setPos(cible.getCelX*@cell_size-(@cell_size/2), cible.getCelZ*@cell_size)
      @mursHitBox[3].collision cible
    end
  end

  def draw
    self.drawMapClip
    #self.drawMapTotal
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
    @batte.draw(@camera, 0, 0, 0, 0, 0, 0)
    #@ruby.draw(@camera, @mursHitBox[3].x, 0, @mursHitBox[1].z, 0, 0, 0)
    Gosu::draw_rect(0, 0, WIDTH, HEIGHT, 0xff2c3e50, -10000)
    #@map.draw
  end

  def drawMapClip
    cibleX = @camera.position.x
    cibleZ = @camera.position.z
    size = 10 * 20

    z = 0
    x = 0

    @map.map.each do |row|
      row.each do |cel|
        if cel != 0
          if (x >= cibleX - size && x <= cibleX + size) && (z >= cibleZ - size && z <= cibleZ + size)
            @listeModeleCellules[cel].draw(@camera, x, 0, z, 0, 0, 0)
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
