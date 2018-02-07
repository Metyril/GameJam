## Dépendances Gems
require 'gosu'  # Librairie graphique Gosu
require_relative 'Item.rb'

class ItemTire < Item
      attr_accessor :vitesse,:degats,:attaqueVit,:startAnime,:modeleTire,:room,:vitesseP
  def initialize(app,room,x,y,z,nom)
    @room = room
    case nom
    when "Pistolet"
      @attaqueVit = 4
      @vitesseP = 2
      @degats = 1
      @modeleTire = CreateModele::projectile
      modele = CreateModele::pistolet
      itbox = 1
    when "Mitraillette"
      @attaqueVit = 2
      @vitesseP = 1
      @degats = 2
      @modeleTire = CreateModele::projetile
      modele = CreateModele::batte
      itbox = 3
    when "Bazooka"
      @attaqueVit = 1
      @vitesseP = 1
      @degats = 4
      @modeleTire = CreateModele::projetile
      modele = CreateModele::batte
      itbox = 3
    end
      @vitesse = 0
      @app = app
      @startAnime = false
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
