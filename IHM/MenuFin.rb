# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

require_relative './Bouton.rb'

class MenuFin < Gosu::Window

    def initialize(score, statut, width=1280, height=720, options={:fullscreen => false})     # options facultatif / update_interval est en ms
      super width, height, options
      @score = score
      @statut = statut
      @cursor = Gosu::Image.new('./media/menus/mouse.png')
      @titre = Gosu::Image.new('./media/menus/messageMenuFin.png')
      if(@statut)
        @statut = Gosu::Image.new('./media/menus/winMenuFin.png')
        self.caption = "Omotecy - Vous avez survécu à la transformation !"
      else
        @statut = Gosu::Image.new('./media/menus/loseMenuFin.png')
        self.caption = "Omotecy - La matrice vous a emprisonnée !"
      end
      @rejouer = Bouton.new(450,500,400,80,Gosu::Color::CYAN,"Rejouer",3)
      @exit = Bouton.new(450,600,400,80,Gosu::Color::CYAN,"Quitter",2.8)
      @txtScore = Gosu::Image.from_text('Score obtenu', 50, {:font => "./media/menus/Basica.ttf", :align => :center})
      @printScore = Gosu::Image.from_text("#{@score}", 100)
    end

    def draw
      @rejouer.draw
      @exit.draw
      @titre.draw 200, 50, 0
      @statut.draw 200, 190, 0
      @txtScore.draw 425, 350, 0
      @printScore.draw 600, 400, 0
      @cursor.draw self.mouse_x, self.mouse_y, 4
    end

    def update
      @mouse_x = mouse_x.to_i+30
      @mouse_y = mouse_y.to_i+10
      if @rejouer.isHover(@mouse_x,@mouse_y)
        @rejouer.color(Gosu::Color::YELLOW)
      elsif @rejouer.getColor == Gosu::Color::YELLOW
        @rejouer.color(Gosu::Color::CYAN)
      end
      if @exit.isHover(@mouse_x,@mouse_y)
        @exit.color(Gosu::Color::YELLOW)
      elsif @exit.getColor == Gosu::Color::YELLOW
        @exit.color(Gosu::Color::CYAN)
      end
    end

    def button_down(id)
      @mouse_x = mouse_x.to_i+30
      @mouse_y = mouse_y.to_i+10
      case id
      when Gosu::MsLeft
        if @rejouer.isHover(@mouse_x,@mouse_y)
          self.close!
          Fenetre.new.show
        end
        if @exit.isHover(@mouse_x,@mouse_y)
          self.close!
          MenuPrincipal.new.show
        end
      end
    end
end