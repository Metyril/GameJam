## Dépendances Gems
require 'gosu'  # Librairie graphique Gosu
require_relative 'Item.rb'

class ItemTire < Item
      attr_accessor :vitesse,:degats,:attaqueVit,:startAnime,:modeleTire,:room,:vitesseP,:nom
  def initialize(app,room,x,y,z)
    @room = room
    rang = rand(3)
    case rang
      when 0
        @nom = "Pistolet"
        @attaqueVit = 4
        @vitesseP = 3
        @degats = 1
        @modeleTire = CreateModele::projectile
        modele = CreateModele::pistolet
        itbox = 1
      when 1
        @nom = "Mitraillette"
        @attaqueVit = 6
        @vitesseP = 2
        @degats = 2
        @modeleTire = CreateModele::projectile(0.5)
        modele = CreateModele::pistolet
        itbox = 3
      when 2
        @nom = "Bazooka"
        @attaqueVit = 1
        @vitesseP = 1
        @degats = 4
        @modeleTire = CreateModele::projectile(0.8)
        modele = CreateModele::pistolet
        itbox = 3
      when 3
        nom = "FusilApompe"
        @attaqueVit = 2
        @vitesseP = 1
    end
    @vitesse = 0
    @app = app
    @startAnime = false
    itbox = 1
    super room , modele, itbox , x,y,z
  end

  def attaque
    if @vitesse <= 0
      @vitesse = 140
      @startAnime = true
      @app.projectiles << Projectile.new(@app,@app.player.angle,@app.player.x,@app.player.y,@app.player.z,@itBox,@degats+@app.player.degats,@modeleTire,@room,@vitesseP)
    end
  end

  def update
        @vitesse -= @attaqueVit + @app.player.vitesseAt
  end
end
