require 'gosu'

require_relative './Element.rb'



class Player < Element
      attr_accessor :vie,:items , :puissance,:arme
    def initialize(map, cell_size,itBox=5,x=0,y=0,vie = 3, puissance =1)
        super
        @vie = vie
        @arme = 0 ;
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

#Gestion des deplacements
  def deplacementX(depl)
    case depl
    when "Z"
      @x = @x + Math.sin(@angle)
      @y = @y + Math.cos(@angle)
    when "S"
      @x = @x + Math.sin(-@angle)
      @y = @y + Math.cos(-@angle)
    when "D"
      @x = @x + Math.sin(@angle+90)
      @y = @y + Math.cos(@angle+90)
    when "Q"
      @x = @x + Math.sin(@angle-90)
      @y = @y + Math.cos(@angle-90)
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



    def draw
        Gosu.draw_rect(@x, @y, @cell_size, @cell_size, Gosu::Color.argb(0xff_ff0000), 2)
    end # Fin draw
end # Fin Player
