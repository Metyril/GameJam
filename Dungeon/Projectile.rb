# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Projectile < Element
    attr_accessor :app,:angle, :degats, :vitesse,:ennemie

    def initialize(app,angle,x,y,z,itbox,degats,modele,room,vitesse)
      super room,modele,itbox,x,y,z,false
      @app = app
      @ennemie = Array.new
      @vitesse = vitesse
      @range = 20 + 10*@app.player.range 
      @angle = angle
      @degats = degats
      @y = -5
    end # Fin initialize

    def avancer()
      @x += Math.sin(@angle)* @vitesse
      @z += Math.cos(@angle)* @vitesse
      @range -= 1
      @app.ennemis.each do |ennemie|
          if Math.sqrt((ennemie.x - @x)**2 + (ennemie.z - @z)**2) < (@itBox + ennemie.itBox)
            ennemie.vie -= @degats
            @ennemie << ennemie
            self.detruire
          end
      end
      if @range < 0
        self.detruire
      end
    end

    def draw camera
      #Gosu.draw_rect(@x, @z, @cell_size, @cell_size, Gosu::Color.argb(0xff_00ff00), 1)
      @modele.draw(camera, @x, @y, @z, 0, -@angle, 0)
    end # Fin draw

end # Fin Element
