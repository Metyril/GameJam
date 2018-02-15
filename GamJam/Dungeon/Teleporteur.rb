require_relative './Ennemi.rb'
require_relative './ItemTire.rb'

class Teleporteur < Element
    def initialize(app,room,modeleTP,itbox = 3, x=0, y=0 ,z=0)
        super room, modeleTP, itbox, x, y, z
        @app = app
        @sonTeleporteur = Gosu::Sample.new('./media/divers/teleporteur.wav')
    end

    def activer
      @sonTeleporteur.play(1)
      @app.etage += 1
      @app.initialisation
    end


end
