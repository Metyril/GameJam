# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

class Piege < Item
    attr_accessor :app

    def initialize(app,room,x=0,y=0,z=0,itbox=2)
      super room,CreateModele::sol,itbox,x,y,z
      @app = app
    end # Fin initialize

    def activeEffet
      for i in 1..2
        @app.ennemis << Ennemi.new(@room, @app.ennemisModele,@app)
      end
    end
end # Fin Element
