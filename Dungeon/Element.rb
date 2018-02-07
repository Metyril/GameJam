# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Element
    attr_accessor :x, :y, :z, :itBox, :isDetruit, :modele

    def initialize(room, modele,itbox=0,x=0,y=0,z=0)
      @room = room
      @modele = modele
      @cell_size = @room.cell_size
      @x = x
      @y = y
      @z = z
      @itBox = itbox

      @isDetruit = false

      self.createElement
    end # Fin initialize

    def detruire
      @isDetruit = true
    end

    def getCelX
      return (@x / @cell_size).round
    end

    def getCelZ
      return (@z / @cell_size).round
    end

    def createElement
      @x, @z = rand(@room.width), rand(@room.height)
      @x = (@x + @room.x_pos) * @cell_size
      @z = (@z + @room.y_pos) * @cell_size
    end # Fin createElement

    def update
    end

    def draw camera
      #Gosu.draw_rect(@x, @z, @cell_size, @cell_size, Gosu::Color.argb(0xff_00ff00), 1)
      @modele.draw(camera, @x, @y, @z, 0, 0, 0)
    end # Fin draw
end # Fin Element
