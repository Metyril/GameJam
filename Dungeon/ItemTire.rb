## Dépendances Gems
require 'gosu'  # Librairie graphique Gosu
require_relative 'Item.rb'

class ItemTire < Item
      attr_accessor :vitesse,:degats,:attaqueVit,:startAnime,:modeleTire,:room,:vitesseP,:nom,:vraiMod
  def initialize(app,room,x=0,y=0,z=0)
    @room = room

    rang = rand(3)
    case rang
      when 0
        @nom = "Pistolet"
        @attaqueVit = 4
        @vitesseP = 3
        @degats = 1
        @modeleTire = CreateModele::projectile
        @vraiMod  = CreateModele::pistolet
        itbox = 1
      when 1
        @nom = "Mitraillette"
        @attaqueVit = 6
        @vitesseP = 2
        @degats = 2
        @modeleTire = CreateModele::projectile(0.5)
        @vraiMod  = CreateModele::pistolet
        itbox = 3
      when 2
        @nom = "Bazooka"
        @attaqueVit = 1
        @vitesseP = 1
        @degats = 4
        @modeleTire = CreateModele::projectile(0.8)
        @vraiMod  = CreateModele::bazooka
        itbox = 3

    end
    @vitesse = 0
    @app = app
    @startAnime = false
    itbox = 1
    super room , @app.modelePointInterrogation, itbox , x,y,z
  end

  def attaque
    if @vitesse <= 0
      @vitesse = 140
      @startAnime = true

      @app.projectiles << Projectile.new(@app,@app.player.angle,@x,@y,@z,@itBox,@degats+@app.player.degats,@modeleTire,@room,@vitesseP)
    end
  end

  def equiper
    @modele = @vraiMod
  end

  def update
        @vitesse -= @attaqueVit + @app.player.vitesseAt
  end
end
