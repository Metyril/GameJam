require 'gosu'

require_relative 'Dungeon/Map.rb'
require_relative 'Dungeon/Player.rb'
require_relative 'Dungeon/Element.rb'
require_relative 'Dungeon/Ennemi.rb'
require_relative 'Dungeon/ObjetRamassable.rb'

require_relative 'Omotecy/createModele.rb'
require_relative 'Omotecy/projectModele.rb'

require_relative 'Dungeon/MurHitBox.rb'
require_relative 'Dungeon/ItemPoing.rb'
require_relative 'Dungeon/ItemTire.rb'
require_relative 'Dungeon/Projectile.rb'
require_relative 'Dungeon/Pilule.rb'
require_relative 'Dungeon/Drone.rb'
require_relative 'Dungeon/Item.rb'
require_relative 'Dungeon/Vie.rb'
require_relative 'Dungeon/MegaPilule.rb'
require_relative 'Dungeon/Particule.rb'

require_relative 'Dungeon/Teleporteur.rb'

require_relative 'IHM/Bouton.rb'

WIDTH = 1280
HEIGHT = 720

DEMIPI = Math::PI/2

class Fenetre < Gosu::Window
  attr_accessor :player, :ennemis, :projectiles, :modeleParicule, :particules, :map,:ramassablesArme,:ramassables,:pilules, :modeleParicule2, :modelePointInterrogation
  def initialize
    super WIDTH, HEIGHT, options = {fullscreen: false}

    Triangle.setRefSize(WIDTH, HEIGHT)

    @map_width = 40         # Largeur de la Map
    @map_height = 40        # Hauteur de la Map
    @cell_size = 20         # Taille d'une cellule
    @wall_size = 5          # Largeur d'un mur
    @nb_room = 10           # Nombre de salles
    @type_gen = 'random'    # Type de génération / 4 valeurs possibles : 'random', 'newest', 'middle', 'oldest'

    @etage = 0

    # MODELES
    @playerModele = CreateModele::player
    @batte = CreateModele::batte
    @modeleRuby = CreateModele::ruby
    @ennemisModele = CreateModele::player(true)
    @modPilule = CreateModele::pilule
    @modeleParicule = CreateModele::sim
    @modeleParicule2 = CreateModele::sim 1
    @modelePointInterrogation= CreateModele::pointInterrogation

    # TELEPORTEUR
    @playerInitPos = rand(0..@nb_room-1)
    @modeleTP = CreateModele::sim
    @teleporteur = Teleporteur.new(self, @map_width, @map_height, @cell_size, @wall_size, @nb_room, @type_gen, @playerInitPos, @batte, @modeleRuby, @ennemisModele, @modeleTP, @modPilule)

    # ATTRIBUTS
    @map = @teleporteur.allSet[:map]
    @projectiles = @teleporteur.allSet[:projectiles]
    @ramassablesArme = @teleporteur.allSet[:ramassablesArme]
    @ennemis = @teleporteur.allSet[:ennemis]
    @ramassables = @teleporteur.allSet[:ramassables]
    @pilules = @teleporteur.allSet[:pilules]
    @drones = @teleporteur.allSet[:drones]
    @particules = @teleporteur.allSet[:particules]
    @vies = @teleporteur.allSet[:vies]

    # AUTRES
    @player = Player.new(@map.rooms[@playerInitPos], @playerModele, ItemPoing.new(self, @map.rooms[@playerInitPos],0,0,0,2))
    @camera = Camera.new(@player.x, @player.y,@player.z-30)
    @pilules << MegaPilule.new(self,@map.rooms[@playerInitPos],0)
    @pilules << MegaPilule.new(self,@map.rooms[@playerInitPos],1)


    @listeModeleCellules = Array.new
    for i in (0..15)
      @listeModeleCellules.push(CreateModele::cellule(i.to_s(2).rjust(4, '0'), 0))
      #@listeModeleCellules.push(CreateModele::cellule("0111"))
    end

    @freeCam = false
    @drawTotal = false


    #               SUD                 NORD                EST                           OUEST
    @mursHitBox = [MurHitBox.new("S"), MurHitBox.new("N"), MurHitBox.new("E"), MurHitBox.new("W")]

    #MENU pause
    @pause = false
    @music = Gosu::Song.new('../media/little_apocalypse.ogg')
    @cursor = Gosu::Image.new('../media/mouse.png')
    @titre = Gosu::Image.new('../media/Omotecy - Titre Final.png')
    @bouton = Bouton.new(500,350,270,80,Gosu::Color::CYAN,"Jouer",3)
    @exit = Bouton.new(500,450,270,80,Gosu::Color::CYAN,"Quitter",2.8)
    @sound_btn = Bouton.new(1100,500,100,100,Gosu::Color::CYAN,"",2.8)
    @sound_image = Gosu::Image.new('../media/sound.png')
    @music.play(true)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      @pause = true
    elsif id == Gosu::KB_TAB
      @freeCam = !@freeCam
      #@drawTotal = !@drawTotal
    end

    #MENU PAUSE
    if id == Gosu::MsLeft
      @mouse_x = mouse_x.to_i+30
      @mouse_y = mouse_y.to_i+10
      if @bouton.isHover(@mouse_x,@mouse_y)
        @pause = false
      end
      if @exit.isHover(@mouse_x,@mouse_y)
        close
      end
      if @sound_btn.isHover(@mouse_x,@mouse_y) && @music.playing?
        @music.pause
      elsif @sound_btn.isHover(@mouse_x,@mouse_y) && !@music.playing?
        @music.play(true)
      end
    end
  end



  def update
    self.caption = "#{Gosu.fps} FPS / vitesse:#{@player.vitesse} Attaque:#{@player.degats} Range:#{@player.range} | VitesseAt:#{@player.vitesseAt} Vie:#{@player.vie}"
    if !@pause
      frontal = 0
      lateral = 0
      frontal = -0.6*@player.vitesse if Gosu.button_down? Gosu::KB_S
      frontal = 0.6*@player.vitesse if Gosu.button_down? Gosu::KB_W
      lateral = -0.4*@player.vitesse if Gosu.button_down? Gosu::KB_A
      lateral = 0.4*@player.vitesse if Gosu.button_down? Gosu::KB_D
      @player.angle += -0.03 if Gosu.button_down? Gosu::KB_LEFT
      @player.angle += 0.03 if Gosu.button_down? Gosu::KB_RIGHT
      @player.x += Math.sin(@player.angle) * frontal + Math.cos(-@player.angle) * lateral
      @player.z += Math.cos(@player.angle) * frontal + Math.sin(-@player.angle) * lateral
      @player.animeDeplacement = (frontal != 0 || lateral != 0)
    end

    if !@freeCam && !@pause
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

    @player.attaque if Gosu.button_down? Gosu::KB_SPACE

    @player.update
    self.murCollision @player
    @projectiles.each do |projectile|
      projectile.avancer
      if self.murCollision projectile
        projectile.detruire
        for i in (0...10)
          @particules << Particule.new(@map.rooms[rand(0..0)], @modeleParicule, projectile.x, projectile.y, projectile.z)
        end
      end
    end

    if !@pause
      @ennemis.each do |ennemi|
        ennemi.detruire if 1 > ennemi.vie
        ennemi.deplacements(@player.x, @player.z)
        if (self.dist(@player, ennemi) < (@player.itBox + ennemi.itBox)) && @player.invulnerable == 0
          @player.vie -= 1
          @player.invulnerable = 70
        end
        self.murCollision ennemi
      end
    end

    if self.dist(@player, @teleporteur) < (@player.itBox + @teleporteur.itBox)
      @playerInitPos = rand(0..@nb_room-1)
      @teleporteur = Teleporteur.new(self, @map_width, @map_height, @cell_size, @wall_size, @nb_room, @type_gen, @playerInitPos, @batte, @modeleRuby, @ennemisModele, @modeleTP, @modPilule)

      @map = @teleporteur.allSet[:map]
      @projectiles = @teleporteur.allSet[:projectiles]
      @ramassablesArme = @teleporteur.allSet[:ramassablesArme]
      @ennemis = @teleporteur.allSet[:ennemis]
      @ramassables = @teleporteur.allSet[:ramassables]
      @pilules = @teleporteur.allSet[:pilules]
      @drones = @teleporteur.allSet[:drones]
      @particules = @teleporteur.allSet[:particules]
      @vies = @teleporteur.allSet[:vies]

      room = @map.rooms[@playerInitPos]
      @player.x, @player.z = rand(room.width), rand(room.height)
      @player.x = (@player.x + room.x_pos) * @cell_size
      @player.z = (@player.z + room.y_pos) * @cell_size

      @camera = Camera.new(@player.x, @player.y,@player.z-30)
    end

    @ramassables.each do |ramassable|
      ramassable.detruire if self.dist(@player, ramassable) < (@player.itBox + ramassable.itBox)
    end
    @vies.each do |ramassable|
      if self.dist(@player, ramassable) < (@player.itBox + ramassable.itBox)
        @player.vie += 1
        ramassable.detruire
      end
    end
    @pilules.each do |pilule|
      if self.dist(@player, pilule) < (@player.itBox + pilule.itBox)
        pilule.activeEffet
        pilule.detruire
      end
    end
    @ramassablesArme.each do |ramassable|
      if self.dist(@player, ramassable) < (@player.itBox + ramassable.itBox)
        @player.arme = ramassable
        ramassable.equiper
        ramassable.detruire
      end
    end
    @drones.each do |ramassable|
      if self.dist(@player, ramassable) < (@player.itBox + ramassable.itBox)
        @player.ajouterItem(ramassable)
        ramassable.detruire
      end
    end
    # @ennemis.each do |ennemi|
    #   ennemi.detruire if self.dist(@player,ennemi) < (@player.itBox + ennemi.itBox)
    # end
    self.iter @vies
    self.iter @drones
    self.iter @pilules
    self.iter @projectiles
    self.iter @ennemis
    self.iter @ramassables
    self.iter @ramassablesArme
    self.iter @particules

    #MENU PAUSE
    @mouse_x = mouse_x.to_i+30
    @mouse_y = mouse_y.to_i+10
    if @bouton.isHover(@mouse_x,@mouse_y)
      @bouton.color(Gosu::Color::YELLOW)
    elsif @bouton.getColor == Gosu::Color::YELLOW
      @bouton.color(Gosu::Color::CYAN)
    end
    if @exit.isHover(@mouse_x,@mouse_y)
      @exit.color(Gosu::Color::YELLOW)
    elsif @exit.getColor == Gosu::Color::YELLOW
      @exit.color(Gosu::Color::CYAN)
    end
    if @sound_btn.isHover(@mouse_x,@mouse_y)
      @sound_btn.color(Gosu::Color::YELLOW)
    elsif @sound_btn.getColor == Gosu::Color::YELLOW
      @sound_btn.color(Gosu::Color::CYAN)
    end
    if @player.vie <= 0
      close
      MenuPrincipal.new.show
    end


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
    val = @map.map[cible.getCelZ][cible.getCelX]
    hit1 = false
    hit2 = false
    hit3 = false
    hit4 = false

    if (val & S) == 0
      @mursHitBox[0].setPos(cible.getCelX*@cell_size, cible.getCelZ*@cell_size+(@cell_size/2))
      hit1 = @mursHitBox[0].collision cible
    end

    if (val & N) == 0
      @mursHitBox[1].setPos(cible.getCelX*@cell_size, cible.getCelZ*@cell_size-(@cell_size/2))
      hit2 = @mursHitBox[1].collision cible
    end

    if (val & E) == 0
      @mursHitBox[2].setPos(cible.getCelX*@cell_size+(@cell_size/2), cible.getCelZ*@cell_size)
      hit3 = @mursHitBox[2].collision cible
    end

    if (val & W) == 0
      @mursHitBox[3].setPos(cible.getCelX*@cell_size-(@cell_size/2), cible.getCelZ*@cell_size)
      hit4 = @mursHitBox[3].collision cible
    end

    return hit1 || hit2 || hit3 || hit4
  end

  def draw
    if @drawTotal
      self.drawMapTotal
    else
      self.drawMapClip
    end

    #@playerModele.draw(@camera, @player.x, @player.y, @player.z, 0, -@player.angle, 0)

    @player.draw(@camera)

    @teleporteur.draw(@camera)

    @playerModele.draw(@camera, 0, 0, 0, 0, 0, 0)
    @batte.draw(@camera, 0, 0, 0, 0, 0, 0)
    #@ruby.draw(@camera, @mursHitBox[3].x, 0, @mursHitBox[1].z, 0, 0, 0)
    Gosu::draw_rect(0, 0, WIDTH, HEIGHT, 0xff2c3e50, -10000)
    #@map.draw

    #MENU PAUSE
    if @pause
      @bouton.draw
      @exit.draw
      @sound_btn.draw
      @titre.draw 50, 100, 2
      @cursor.draw self.mouse_x, self.mouse_y, 4
      @sound_image.draw 1110, 510, 2
    end
  end

  def redraw?(x, z)
    cibleX = @camera.position.x
    cibleZ = @camera.position.z
    size = 10 * @cell_size
    return (x >= cibleX - size && x <= cibleX + size) && (z >= cibleZ - size && z <= cibleZ + size)
  end

  def drawMapClip
    z = 0
    x = 0

    @map.map.each do |row|
      row.each do |cel|
        if cel != 0
          if redraw?(x, z)
            @listeModeleCellules[cel].draw(@camera, x, 0, z, 0, 0, 0)
          end
        end
        x += 20
      end
      z += 20
      x = 0
    end

    @ramassables.each do |ramassable|
      if redraw?(ramassable.x, ramassable.z)
        ramassable.draw(@camera)
      end
    end
    @vies.each do |ramassable|
      if redraw?(ramassable.x, ramassable.z)
        ramassable.draw(@camera)
      end
    end
    @drones.each do |ramassable|
      if redraw?(ramassable.x, ramassable.z)
        ramassable.draw(@camera)
      end
    end
    @pilules.each do |ramassable|
      if redraw?(ramassable.x, ramassable.z)
        ramassable.draw(@camera)
      end
    end
    @ramassablesArme.each do |ramassable|
      if redraw?(ramassable.x, ramassable.z)
        ramassable.draw(@camera)
      end
    end
    @projectiles.each do |ramassable|
      if redraw?(ramassable.x, ramassable.z)
        ramassable.draw(@camera)
      end
    end

    @particules.each do |ramassable|
      if redraw?(ramassable.x, ramassable.z)
        ramassable.draw(@camera)
      end
    end

    @ennemis.each do |ennemi|
      if redraw?(ennemi.x, ennemi.z)
        ennemi.draw(@camera)
      end
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

    @ramassables.each do |ramassable|
      ramassable.draw(@camera)
    end

    @ennemis.each do |ennemi|
      ennemi.draw(@camera)
    end

    @projectiles.each do |ennemi|
      ennemi.draw(@camera)
    end

    @ramassablesArme.each do |ennemi|
      ennemi.draw(@camera)
    end
  end
end

#Fenetre.new.show
