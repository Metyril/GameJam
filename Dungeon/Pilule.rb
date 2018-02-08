# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Pilule < Item
    attr_accessor :app,:nom

    def initialize(app,room,x=0,y=0,z=0,itbox=1)
      @app = app
      @angle = rand(-3..3)
      case rand(7)
        when 0
          @nom = "Vitesse +"
        when 1
          @nom = "Vitesse -"
        when 2
          @nom = "Attaque +"
        when 3
          @nom = "Attaque -"
        when 4
          @nom = "Range +"
        when 5
          @nom = "Range -"
        when 6
          @nom = "Vitesse Att +"
        when 7
          @nom = "Vitesse Att -"
      end
      super room,@app.modPilule,itbox,x,y,z
    end # Fin initialize

    def activeEffet
      case @nom
      when "Vitesse +"
        if @app.player.vitesse < 2
          @app.player.vitesse += 0.2
          @app.player.ajouterItem(self)
        end
      when "Vitesse -"
        if @app.player.vitesse > 0.5
          @app.player.vitesse -= 0.2
          @app.player.ajouterItem(self)
        end
      when "Attaque +"
        @app.player.degats += 0.5
        @app.player.ajouterItem(self)
      when "Attaque -"
        @app.player.degats -= 0.5
        @app.player.ajouterItem(self)
      when "Range +"
        @app.player.range += 1
        @app.player.ajouterItem(self)
      when "Range -"
        if @app.player.range > -1
          @app.player.range -= 1
          @app.player.ajouterItem(self)
        end
      when "Vitesse Att +"
        @app.player.vitesseAt += 1
        @app.player.ajouterItem(self)
      when "Vitesse Att -"
        if @app.player.vitesseAt > -0.5
          @app.player.vitesseAt -= 0.5
          @app.player.ajouterItem(self)
        end
      end
    end

    def draw camera
      #Gosu.draw_rect(@x, @z, @cell_size, @cell_size, Gosu::Color.argb(0xff_00ff00), 1)
      @angle += 0.02
      @modele.draw(camera, @x, @y, @z, 0, -@angle, 0)
    end # Fin draw
end # Fin Element
