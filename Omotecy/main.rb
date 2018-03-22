require 'gosu'

require_relative '../Dungeon/Map.rb'
require_relative '../Dungeon/Player.rb'
require_relative '../Dungeon/Element.rb'
require_relative '../Dungeon/Ennemi.rb'
require_relative '../Dungeon/ObjetRamassable.rb'
require_relative '../Dungeon/MurHitBox.rb'
require_relative '../Dungeon/ItemPoing.rb'
require_relative '../Dungeon/ItemTire.rb'
require_relative '../Dungeon/Projectile.rb'
require_relative '../Dungeon/Pilule.rb'
require_relative '../Dungeon/Drone.rb'
require_relative '../Dungeon/Item.rb'
require_relative '../Dungeon/Vie.rb'
require_relative '../Dungeon/MegaPilule.rb'
require_relative '../Dungeon/Piege.rb'
require_relative '../Dungeon/MegaZombie.rb'
require_relative '../Dungeon/Particule.rb'
require_relative '../Dungeon/Teleporteur.rb'
require_relative '../Dungeon/Laser.rb'

require_relative '../IHM/Bouton.rb'
require_relative '../IHM/MenuFin.rb'

require_relative './createModele.rb'
require_relative './projectModele.rb'

WIDTH = 1280
HEIGHT = 720

DEMIPI = Math::PI/2

class Fenetre < Gosu::Window
  attr_accessor :player, :ennemis,:drones, :projectiles,  :particules, :map, :ramassablesArme, :ramassables, :pilules, :ennemisModele, :etage, :score, :pieges,:gagner,:bossModele
  attr_accessor :modeleParicule, :modeleParicule2, :modelePointInterrogation,:modeleProjectileVert,:modeleDrone,:modPilule,:modeleRuby,:modeleProjectile,:modelePiege
  attr_accessor :sonRubis, :sonTeleporteur,:sonFin
  def initialize
    super WIDTH, HEIGHT, options = {fullscreen: true}

    Triangle.setRefSize(WIDTH, HEIGHT)
    @map_width = 40         # Largeur de la Map
    @map_height = 40        # Hauteur de la Map
    @cell_size = 20         # Taille d'une cellule
    @wall_size = 5          # Largeur d'un mur
    @nb_room = 10           # Nombre de salles
    @type_gen = 'random'    # Type de génération / 4 valeurs possibles : 'random', 'newest', 'middle', 'oldest'
    @gagner = false

    @score = 0
    @etage = 0
    @fontHUD = Gosu::Font.new 30
    @iconRuby = Gosu::Image.new('./media/hud/iconRuby.png')
    @iconZombie = Gosu::Image.new('./media/hud/iconZombie.png')

    @afficheUHD = true

    # MODELES
    @playerModele = CreateModele::player
    @batte = CreateModele::batte
    @modeleRuby = CreateModele::ruby
    @ennemisModele = CreateModele::player(true)
    @bossModele = CreateModele::player(true,true)
    @modPilule = CreateModele::pilule
    @modeleParicule = CreateModele::sim
    @modeleProjectileVert = CreateModele::projectile(0.5,0xff1abc9c,0xff16a085)
    @modeleProjectile = CreateModele::projectile
    @modeleParicule2 = CreateModele::sim 1
    @modeleDrone = CreateModele::sim 2
    @modelePiege = CreateModele::sol
    @modelePointInterrogation = CreateModele::pointInterrogation
    @modeleTP = CreateModele::teleporteur

    self.initialisation

    # AUTRES


    @sonFin = Gosu::Sample.new('./media/divers/mort_son.wav')
    @sonTeleporteur = Gosu::Sample.new('./media/divers/teleporteur.wav')
    @sonTeleporteur.play(1)
    @sonRubis = Gosu::Sample.new('./media/divers/ruby.wav')

    @freeCam = false
    @drawTotal = false


    #               SUD                 NORD                EST                           OUEST
    @mursHitBox = [MurHitBox.new("S"), MurHitBox.new("N"), MurHitBox.new("E"), MurHitBox.new("W")]

    #MENU pause
    @pause = false
    @music = Gosu::Song.new('./media/musiques/little_apocalypse.ogg')
    @cursor = Gosu::Image.new('./media/menus/mouse.png')
    @titre = Gosu::Image.new('./media/menus/Pause3D.png')
    @bouton = Bouton.new(500,350,350,80,Gosu::Color::CYAN,"Jouer",3)
    @exit = Bouton.new(500,450,350,80,Gosu::Color::CYAN,"Quitter",2.8)
    @sound_btn = Bouton.new(1100,500,100,100,Gosu::Color::CYAN,"",2.8)
    @sound_image = Gosu::Image.new('./media/menus/sound.png')
    @music.play(true)
  end

###########################################################################################################################
##################################### Initialisation de la partie #########################################################
###########################################################################################################################

  def initialisationDesAttributs
    # ATTRIBUTS
      @projectiles = Array.new
      @ramassablesArme = Array.new
      @ennemis = Array.new
      @ramassables = Array.new
      @pilules = Array.new
      @drones = Array.new
      @particules = Array.new
      @vies = Array.new
      @pieges = Array.new
      @map.rooms.each do |room|
        room.ennemis = 0
      end

  end
  def spone(room,type,proba,nbTour)                                              # Ajoute les Zombies Item et + dans la salle
    for i in 1 .. nbTour
      if rand < proba
        case type
        when "Zombie"
          enne = Ennemi.new(room, @ennemisModele,self)
          @ennemis << enne
          room.ennemis += 1
        when "ZombieCracheur"
          enne = Ennemi.new(room, @ennemisModele,self,3,0,0,0,true)
          @ennemis << enne
          room.ennemis += 1
        when "Ruby"
          @ramassables << ObjetRamassable.new(room,@modeleRuby)
        when "Pilule"
          @pilules << Pilule.new(self,room)
        when "MegaPilule"
          @pilules << MegaPilule.new(self,room)
        when "Drone"
          @drones << DroneAt.new(self,room)
        when "ItemPoing"
          @ramassablesArme << ItemPoing.new(self,room)
        when "ItemTire"
          @ramassablesArme << ItemTire.new(self,room)
        when "Vie"
          @vies << Vie.new(room)
        when "Piege"
          @pieges << Piege.new(self,room)
        when "MegaZombie"
          @ennemis << MegaZombie.new(room, @bossModele, self, 5,0,0,0,true)
        end
      end
    end
  end
  def initialisation
    if etage == 4
      @nb_room = 2
    end
    @map = Map.new(@map_width,@map_height,@cell_size,@wall_size,@nb_room,@type_gen)
    @playerInitPos = rand(0..@nb_room-1)
    roomT = @playerInitPos
    while roomT == @playerInitPos
      roomT = rand(0..@nb_room-1)
    end
    @teleporteur = 0
    self.initialisationDesAttributs
    @map.rooms.each_with_index do |room, r|                                       # Pour toutes les salles, rajouter Item
      if r != @playerInitPos                                                      # On ne rajoute rien dans la salle du joueur
        if @etage == 0                                                            # Différentes probabilitées selon l'étage
          self.spone(room,"Zombie",0.5,10)
          self.spone(room,"Ruby",0.5,15)
          self.spone(room,"Pilule",0.5,3)
          self.spone(room,"MegaPilule",0.5,1)
          self.spone(room,"Drone",0.2,1)
          self.spone(room,"ItemPoing",0.5,1)
          self.spone(room,"Vie",0.1,1)
          self.spone(room,"Piege",0.5,2)
        elsif @etage == 1
          self.spone(room,"Zombie",0.5,10)
          self.spone(room,"ZombieCracheur",0.5,7)
          self.spone(room,"Ruby",0.5,15)
          self.spone(room,"Pilule",0.5,3)
          self.spone(room,"MegaPilule",0.5,1)
          self.spone(room,"Drone",0.2,1)
          self.spone(room,"ItemPoing",0.5,1)
          self.spone(room,"ItemTire",0.5,1)
          self.spone(room,"Vie",0.1,1)
          self.spone(room,"Piege",0.5,2)
        elsif @etage == 2
          self.spone(room,"Zombie",0.5,13)
          self.spone(room,"ZombieCracheur",0.5,8)
          self.spone(room,"Ruby",0.5,15)
          self.spone(room,"Pilule",0.5,3)
          self.spone(room,"MegaPilule",0.5,2)
          self.spone(room,"Drone",0.2,1)
          self.spone(room,"ItemPoing",0.5,1)
          self.spone(room,"ItemTire",0.5,1)
          self.spone(room,"Vie",0.1,1)
          self.spone(room,"Piege",0.5,2)
        elsif @etage == 3
          self.spone(room,"Zombie",0.5,15)
          self.spone(room,"ZombieCracheur",0.5,10)
          self.spone(room,"Ruby",0.5,15)
          self.spone(room,"Pilule",0.5,3)
          self.spone(room,"MegaPilule",0.5,2)
          self.spone(room,"Drone",0.2,3)
          self.spone(room,"ItemPoing",0.5,2)
          self.spone(room,"ItemTire",0.5,2)
          self.spone(room,"Vie",0.1,3)
          self.spone(room,"Piege",0.5,2)
        elsif @etage == 4
          self.spone( room, "MegaZombie", 2, 1)
          self.spone(room,"Piege",1,10)
        end
          if @etage != 4 && r == roomT
            @teleporteur = Teleporteur.new(self,room,@modeleTP)
          end
      end
    end
    self.setModelesMurs
    if etage == 0
      @player = Player.new(@map.rooms[@playerInitPos], @playerModele, ItemTire.new(self, @map.rooms[@playerInitPos],0,0,0))
      @camera = Camera.new(@player.x, @player.y,@player.z-30)
    else
      minX = @map.rooms[@playerInitPos].x_pos*@map.rooms[@playerInitPos].cell_size
      minZ = @map.rooms[@playerInitPos].y_pos*@map.rooms[@playerInitPos].cell_size
      maxX = (@map.rooms[@playerInitPos].x_pos+@map.rooms[@playerInitPos].width-1)*@map.rooms[@playerInitPos].cell_size
      maxZ = (@map.rooms[@playerInitPos].y_pos+@map.rooms[@playerInitPos].height-1)*@map.rooms[@playerInitPos].cell_size
      @player.x = rand(minX..maxX)
      @player.z = rand(minZ..maxZ)
    end

  end


  def setModelesMurs
    @listeModeleCellules = Array.new
    for i in (0..15)
      @listeModeleCellules.push(CreateModele::cellule(i.to_s(2).rjust(4, '0'), @etage))
    end
  end
  def button_down(id)
    if id == Gosu::KbEscape
      @pause = true
    elsif id == Gosu::KB_TAB
      @freeCam = !@freeCam
      #@drawTotal = !@drawTotal
    elsif id == Gosu::KB_V
      @afficheUHD = !@afficheUHD
    end

    #MENU PAUSE
    if id == Gosu::MsLeft
      @mouse_x = mouse_x.to_i+30
      @mouse_y = mouse_y.to_i+10
      if @bouton.isHover(@mouse_x,@mouse_y)
        @pause = false
      end
      if @exit.isHover(@mouse_x,@mouse_y)
        self.close!
        MenuPrincipal.new.show
      end
      if @sound_btn.isHover(@mouse_x,@mouse_y) && @music.playing?
        @music.pause
      elsif @sound_btn.isHover(@mouse_x,@mouse_y) && !@music.playing?
        @music.play(true)
      end
    end
  end



  def update
    if !@gagner
      self.caption = "Omotecy (#{Gosu.fps} FPS)"
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
        @player.attaque if Gosu.button_down? Gosu::KB_SPACE
        @player.update
        self.murCollision @player


        if @teleporteur !=0
          if @teleporteur.room.active && self.dist(@player, @teleporteur) < (@player.itBox + @teleporteur.itBox)
            @teleporteur.activer
          end
        end
      end

      @map.rooms.each do |room|
        room.activerRoom
      end

      #################################
      #update des objets
      @ennemis.each do |ennemi|
        if 1 > ennemi.vie
          ennemi.room.ennemis -= 1
          ennemi.detruire
        end
        ennemi.deplacements(@player.x, @player.z)
        ennemi.attaque
        if (self.dist(@player, ennemi) < (@player.itBox + ennemi.itBox)) && @player.invulnerable == 0
          @player.vie -= 1
          if rand > 0.5
            @player.cri02.play(1)
          else
            @player.cri03.play(1)
          end
          @player.invulnerable = 70
        end
        self.murCollision ennemi
      end

      @ramassables.each do |ramassable|                                       #Pour les ruby
        if ramassable.room.active
          if self.dist(@player, ramassable) < (@player.itBox + ramassable.itBox)
            ramassable.detruire
            @player.nbRuby += 1
            @sonRubis.play(1)
          end
        end
      end

      @vies.each do |ramassable|                                              #Pour les vies
        if ramassable.room.active
          if self.dist(@player, ramassable) < (@player.itBox + ramassable.itBox)
            @player.vie += 1
            ramassable.detruire
          end
        end
      end
      @pilules.each do |pilule|                                               #Pour les pilules
        if pilule.room.active
          if self.dist(@player, pilule) < (@player.itBox + pilule.itBox)
            pilule.activeEffet
            pilule.detruire
          end
        end
      end
      @pieges.each do |pilule|                                                #Pour les pieges
        if pilule.room.active
          if self.dist(@player, pilule) < (@player.itBox + pilule.itBox)
            pilule.activeEffet
            pilule.detruire
          end
        end
      end
      @ramassablesArme.each do |ramassable|                                   #Pour les armes
        if ramassable.room.active
          if self.dist(@player, ramassable) < (@player.itBox + ramassable.itBox)
            @player.arme = ramassable
            ramassable.equiper
            ramassable.detruire
          end
        end
      end
      @drones.each do |ramassable|                                            #Pour les drones
        if ramassable.room.active
          if self.dist(@player, ramassable) < (@player.itBox + ramassable.itBox)
            @player.ajouterItem(ramassable)
            ramassable.detruire
          end
        end
      end
      @projectiles.each do |projectile|                               #Pour les projectiles
          projectile.avancer
            if self.murCollision projectile
              projectile.detruire
              for i in (0...10)
                  @particules << Particule.new(@map.rooms[rand(0..0)], @modeleParicule, projectile.x, projectile.y, projectile.z)
              end
            end
      end
      @particules.each do |par|
        if par.aoe
          @ennemis.each do |ennemie|
            if Math.sqrt((ennemie.x - par.x)**2 + (ennemie.z - par.z)**2) < (par.itBox + ennemie.itBox)
              par.mettreDegat(ennemie)
            end
          end
        end
      end
      self.iter @pieges
      self.iter @vies
      self.iter @drones
      self.iter @pilules
      self.iter @projectiles
      self.iter @ramassables
      self.iter @ramassablesArme
      self.iter @particules

      @ennemis.delete_if do |elem|
        elem.update
        if elem.isDetruit
          @player.nbZombie += 1
          if elem.is_a? MegaZombie
            @gagner = true
          end
        end
        elem.isDetruit
      end

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
        @player.sonMort.play(1)
        @sonFin.play(1)
        @score = @player.nbRuby + 10*(@player.nbZombie) + 100
        self.close!
        MenuFin.new(@score, @gagner).show
      end
    else
      #CEST LA FIN
      @sonFin.play(1)
      @score = @player.nbRuby + 10*(@player.nbZombie) + 100
      self.close!
      MenuFin.new(@score, @gagner).show
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

    @player.draw(@camera)

    #MENU PAUSE
    if @pause
      @bouton.draw
      @exit.draw
      @sound_btn.draw
      @titre.draw 390, 150, 2
      @cursor.draw self.mouse_x, self.mouse_y, 4
      @sound_image.draw 1110, 510, 2
    else
      if @afficheUHD
        #HUD
        Gosu::draw_rect(20, 20, @player.vie * 47, 20, 0xffff0000, 10)
        Gosu::draw_rect(20, 50, 140 - @player.arme.vitesse, 20, 0xffffff00, 10)

        @iconRuby.draw(20, 80, 10)
        @iconZombie.draw(20, 150, 10)

        @fontHUD.draw("x #{@player.nbRuby}", 90, 95, 10, 1.5, 1.5, 0xffffffff)
        @fontHUD.draw("x #{@player.nbZombie}", 90, 165, 10, 1.5, 1.5, 0xffffffff)

        @fontHUD.draw("Bonus: ", 20, 230, 101, 1, 1, 0xffffffff)
        @fontHUD.draw("Vitesse: #{((@player.vitesse-1).round(1))}", 30, 265, 10, 1, 1, 0xffffffff)
        @fontHUD.draw("Attaque: #{(@player.degats.round(1))}", 30, 300, 10, 1, 1, 0xffffffff)
        @fontHUD.draw("Range: #{(@player.range.round(1))}", 30, 335, 10, 1, 1, 0xffffffff)
        @fontHUD.draw("VitesseAt: #{(@player.vitesseAt.round(1))}", 30, 370, 10, 1, 1, 0xffffffff)
      end
    end

    Gosu::draw_rect(0, 0, WIDTH, HEIGHT, 0xff2c3e50, -10000)
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
        if ramassable.room.active && redraw?(ramassable.x, ramassable.z)
          ramassable.draw(@camera)
        end
      end
      @pieges.each do |ramassable|
        if ramassable.room.active && redraw?(ramassable.x, ramassable.z)
          ramassable.draw(@camera)
        end
      end
      @vies.each do |ramassable|
        if ramassable.room.active && redraw?(ramassable.x, ramassable.z)
          ramassable.draw(@camera)
        end
      end
      @drones.each do |ramassable|
        if ramassable.room.active && redraw?(ramassable.x, ramassable.z)
          ramassable.draw(@camera)
        end
      end
      @pilules.each do |ramassable|
        if ramassable.room.active && redraw?(ramassable.x, ramassable.z)
          ramassable.draw(@camera)
        end
      end
      @ramassablesArme.each do |ramassable|
        if ramassable.room.active && redraw?(ramassable.x, ramassable.z)
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

    if @teleporteur != 0
      if @teleporteur.room.active
        @teleporteur.draw(@camera)
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
    if @teleporteur != 0
      @teleporteur.draw(@camera)
    end

  end
end
