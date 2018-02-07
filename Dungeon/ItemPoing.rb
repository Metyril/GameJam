# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu
require_relative 'Item.rb'

class ItemPoing < Item
      attr_accessor :vitesse,:range,:degats,:attaqueVit,:startAnime,:nom,:vraiMod
  def initialize(app,room,x=0,y=0,z=0,oui = 0)
    modele = CreateModele::pointInterrogation
    if oui == 2
      rang = 2
    else
      rang = rand(1)
    end
    case rang
    when 0
      @nom = "Batte"
      @range = 8
      @attaqueVit = 2
      @degats = 2
      @vraiMod = CreateModele::batte
      itbox = 3
    when 1
      @nom = "Hache"
      @range = 10
      @attaqueVit = 1
      @degats = 4
      @vraiMod = CreateModele::hache
      itbox = 5
    when 2
      @nom = "Main"
      @range = 3
      @attaqueVit = 4
      @degats = 1
      modele =  CreateModele::cube
      itbox = 3
    end
      @vitesse = 0qz 
      @app = app
      @startAnime = false

      @objetDeFrappe = Element.new(room, CreateModele::sim, 2)

      super room , modele, itbox , x,y,z
  end

  def attaque
    if @vitesse <= 0
      @vitesse = 140
      @startAnime = true

        @app.ennemis.each do |ennemie|
          @objetDeFrappe.x = Math.sin(@app.player.angle) + @app.player.x
          @objetDeFrappe.z = Math.cos(@app.player.angle) + @app.player.z

          if !@app.murCollision @objetDeFrappe
            @objetDeFrappe.x = Math.sin(@app.player.angle) * (@range+@app.player.range) + @app.player.x
            @objetDeFrappe.z = Math.cos(@app.player.angle) * (@range+@app.player.range) + @app.player.z
          end

          if Math.sqrt((ennemie.x - @objetDeFrappe.x)**2 + (ennemie.z - @objetDeFrappe.z)**2) < (@itBox + ennemie.itBox)
            ennemie.vie -= @degats+@app.player.degats
            ennemie.recul
            for i in (0...5)
              @app.particules << Particule.new(@app.map.rooms[rand(0..0)], @app.modeleParicule2, ennemie.x, ennemie.y, ennemie.z)
            end
          end
        end

      end
  end

  def equiper
    @modele = @vraiMod
  end

  def update
    @vitesse -= @attaqueVit + @app.player.vitesseAt
  end
end
