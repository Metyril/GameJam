# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Pilule < Item
    attr_accessor :app,:nom

    def initialize(app,room,modele,x=0,y=0,z=0,itbox=1)
      super room,modele,itbox,x,y,z
      @app = app
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
    end # Fin initialize

    def activeEffet
      case @nom
      when "Vitesse +"
        if @app.player.vitesse < 3
          @app.player.vitesse += 0.5
          @app.player.ajouterItem(self)
        end
      when "Vitesse -"
        if @app.player.vitesse > 0.5
          @app.player.vitesse -= 0.5
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
end # Fin Element
