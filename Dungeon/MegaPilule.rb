# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class MegaPilule < Item
    attr_accessor :app,:nom

    def initialize(app,room,x=0,y=0,z=0,itbox=2)
      super room,CreateModele::pilule,itbox,x,y,z
      @app = app
      @angle = rand(-3..3)
      h = rand(4)
      case h
        when 0
          @nom = "Zombie"
        when 1
          @nom = "Explosion"
        when 2
          @nom = "Armement"
        when 3
          @nom = "Rubis"
        when 4
          @nom = "Pillule"
      end
    end # Fin initialize

    def activeEffet
      case @nom
      when "Zombie"
        j = rand(2..10)
        for i in 1..j
          @app.ennemis << Ennemi.new(@room, CreateModele::player(true))
        end
      when "Explosion"
        @app.ennemis.each do |ennemie|
          if ennemie.room == @room
            ennemie.detruire
          end
        end
      when "Armement"
        j = rand( 3..5)
        for i in 1..j
          if rand < 0.5
            @app.ramassablesArme << ItemTire.new(@app,@room)
          else
            @app.ramassablesArme << ItemPoing.new(@app,@room)
          end
        end
      when "Rubis"
          j = rand(8..15)
          for i in 1..j
            @app.ramassables << ObjetRamassable.new(@room , CreateModele::ruby)
          end
      when "Pillule"
        j = rand( 3..5)
        for i in 1..j
          @app.pilules << Pilule.new(@app,@room,CreateModele::pilule)
        end
      end
    end

    def draw camera
      #Gosu.draw_rect(@x, @z, @cell_size, @cell_size, Gosu::Color.argb(0xff_00ff00), 1)
      @angle += 0.02
      @modele.draw(camera, @x, @y, @z, 0, -@angle, 0)
    end # Fin draw
end # Fin Element
