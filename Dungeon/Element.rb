# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Element
    attr_accessor :x, :y, :z, :itBox, :isDetruit, :modele

    def initialize(map,modele,itbox=0,x=0,y=0,z=0)
      @modele = modele
        @map = map
        @cell_size = @map.cell_size
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
      return (@x / @map.cell_size).round
    end

    def getCelZ
      return (@z / @map.cell_size).round
    end

    def getCelVal
      return @map.map[self.getCelZ][self.getCelX]
    end

    def createElement
        @x, @z = rand(@map.width), rand(@map.height)
        while @map.map[@z][@x] < 15
            @x, @z = rand(@map.width), rand(@map.height)
        end
        @x *= @cell_size
        @z *= @cell_size
        #@z = ((@map.width-1) * @cell_size) - @z
    end # Fin createElement

    def update
    end

    def draw camera
        #Gosu.draw_rect(@x, @z, @cell_size, @cell_size, Gosu::Color.argb(0xff_00ff00), 1)
        @modele.draw(camera, @x, @y, @z, 0, 0, 0)
    end # Fin draw
end # Fin Element
