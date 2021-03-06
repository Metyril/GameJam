# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Laser < Projectile
    attr_accessor :app,:angle, :degats, :vitesse,:ennemie,:cracha,:aoe

    def initialize(app,angle,x,y,z,itbox,degats,modele,room,vitesse,cracha = false,range = 20)
      super app,angle,x,y,z,itbox,degats,modele,room,vitesse,cracha,range
      @ennemisToucher = Array.new()
    end # Fin initialize

    def avancer()
      @x += Math.sin(@angle)* @vitesse
      @z += Math.cos(@angle)* @vitesse
      @range -= 1
      if !@cracha
        @app.ennemis.each do |ennemie|
          if !self.dejaToucher(ennemie)
            if Math.sqrt((ennemie.x - @x)**2 + (ennemie.z - @z)**2) < (@itBox + ennemie.itBox)

                ennemie.vie -= @degats
                @ennemie << ennemie
                @ennemisToucher << ennemie
              room = @app.map.rooms[rand(0..0)]
              for i in (0...5)
                if aoe
                    @app.particules << Particule.new(room, @app.modeleParicule2, @x, @y, @z,true)
                else
                    @app.particules << Particule.new(room, @app.modeleParicule2, @x, @y, @z)
                end

              end
            end
          end
        end
      else
        if Math.sqrt((@app.player.x - @x)**2 + (@app.player.z - @z)**2) < (@itBox + @app.player.itBox) && @app.player.invulnerable <= 0
          @app.player.vie -= 1
          @app.player.invulnerable = 70
          @rand = rand(1.5).to_i
          if @rand == 0
            @app.player.cri02.play(1)
          elsif @rand == 1
            @app.player.cri03.play(1)
          end
        end
      end
      if @range < 0
        self.detruire
      end
    end

    def dejaToucher(e)
      toucher = false
      @ennemisToucher.each do |ennemi|
        if e == ennemi
          toucher = true
        end
      end
      return toucher
    end


    def draw camera
      @modele.draw(camera, @x, @y, @z, 0, -@angle, 0)
    end # Fin draw

end # Fin Element
