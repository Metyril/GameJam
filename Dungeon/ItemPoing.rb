# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu
require_relative 'Item.rb'

class ItemPoing < Item
      attr_accessor :vitesse,:range,:degats,:attaqueVit,:startAnime,:nom,:vraiMod, :son, :rate
  def initialize(app,room,x=0,y=0,z=0,oui = 0)
    modele = CreateModele::pointInterrogation
    if oui == 2
      rang = 2
    else
      rang = rand(2)
    end
    case rang
    when 0
      @nom = "Batte"
      @range = 8
      @attaqueVit = 2
      @degats = 2
      @vraiMod = CreateModele::batte
      @son = Gosu::Sample.new('../media/armes/claque.wav')
      itbox = 3
    when 1
      @nom = "Hache"
      @range = 10
      @attaqueVit = 1
      @degats = 4
      @vraiMod = CreateModele::hache
      @son = Gosu::Sample.new('../media/armes/hache.wav')
      itbox = 5
    when 2
      @nom = "Main"
      @range = 3
      @attaqueVit = 4
      @degats = 1
      modele =  CreateModele::cube
      @son = Gosu::Sample.new('../media/armes/claque.wav')
      itbox = 3
    end
      @vitesse = 0
      @app = app
      @startAnime = false
      @sonRecup = Gosu::Sample.new('../media/divers/chgmt_arme.wav')


      @objetDeFrappe = Element.new(room, CreateModele::sim, 2)
      @rate = Gosu::Sample.new('../media/armes/coup_air.wav')
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
            @son.play(1)
            for i in (0...5)
              @app.particules << Particule.new(@app.map.rooms[rand(0..0)], @app.modeleParicule2, ennemie.x, ennemie.y, ennemie.z)
            end
          else
            @rate.play(0.1)
          end
        end

      end
  end

  def equiper
    @sonRecup.play(1)
    @modele = @vraiMod
  end

  def update
    if @vitesse > 0
      @vitesse -= @attaqueVit + @app.player.vitesseAt
    else
      @vitesse = 0
    end
  end
end
