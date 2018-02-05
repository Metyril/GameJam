# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Projectile < Element
    attr_accessor :vitesse,:angle

    def initialize(map, cell_size,itbox,x,y,vitesse,angle)
      @vitesse = vitesse
      @angle = angle
    end # Fin initialize

    def avancer()
      @x = @x + @vitesse*Math.sin(@angle)
      @y = @y + @vitesse*Math.cos(@angle)
    end

end # Fin Element
