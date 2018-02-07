require 'gosu'

require_relative './Element.rb'

class Player < Element
      attr_accessor :vie,:items , :puissance,:arme,:angle,:vitesse, :angle
    def initialize(room, map, modele, itbox=1, x=0, y=0, z=0, vie = 3, puissance =1)
        super room, map, modele, itbox, x, y, z
        @angle = 0
        @vie = vie
        @arme = 0
        @vitesse = 1
        @puissance = puissance
        @items = Array.new()
    end

#Gestion de la vie du joueur

    def ajouterVie(ajout = 1)
      @vie = @vie + ajout
    end

    def enleverVie(enleve = 1)
      @vie = @vie - enleve
    end

#Gestion de la puissance
    def ajouterPuissance(ajout = 1)
      @puissance = @puissance + ajout
    end
    def enleverPuissance(enleve = 1)
      @puissance = @puissance - enleve
    end
#Gestion des Items

  def ajouterItem(ajout)
    @items<<ajout
  end

  def enleverItem(enleve)
    for nb in @items.lenght-1
      if @items.splice(nb) == enleve
        @items.splice!(nb)
      end
    end
  end

  def changementAngle(angle)
    @angle = angle
  end

  def frapper()
    return @arme.frapper(@x,@y,@angle)
  end

  def tirer()
    return @arme.tirer(@x,@y,@angle)
  end

  def draw cam
    @modele.draw(cam, @x, @y, @z, 0, -@angle, 0)
      #Gosu.draw_rect(@x, @y, @cell_size, @cell_size, Gosu::Color.argb(0xff_ff0000), 2)
  end # Fin draw
end # Fin Player
