# Dépendances Gems
require 'gosu'  # Librairie graphique Gosu

require_relative 'Bouton.rb'
require_relative 'Credits.rb'
require_relative 'Commandes.rb'
require_relative '../main.rb'

class MenuPrincipal < Gosu::Window

    def initialize(width=1280, height=720, options={:fullscreen => false})     # options facultatif / update_interval est en ms
      super
      self.caption = 'Omotecy'
      @background = Gosu::Image.new("../media/background.png")
      @cursor = Gosu::Image.new('../media/mouse.png')
      @titre = Gosu::Image.new('../media/Omotecy - Titre Final.png')
      @play = Bouton.new(400,300,450,80,Gosu::Color::CYAN,"Jouer",3)
      @credits = Bouton.new(400,400,450,80,Gosu::Color::CYAN,"Credits",2.8)
      @commandes = Bouton.new(400,500,450,80,Gosu::Color::CYAN,"Commandes",2.8)
      @exit = Bouton.new(400,600,450,80,Gosu::Color::CYAN,"Quitter",2.8)
      @music = Gosu::Song.new('../media/warm_welcome_to_hell_o.ogg')
      @sound_btn = Bouton.new(1100,500,100,100,Gosu::Color::CYAN,"",2.8)
      @sound_image = Gosu::Image.new('../media/sound.png')
      @music.play(true)
    end

    def draw
      @play.draw
      @credits.draw
      @commandes.draw
      @exit.draw
      @sound_btn.draw
      @background.draw 0,0,0
      @titre.draw 50, 100, 2
      @cursor.draw self.mouse_x, self.mouse_y, 4
      @sound_image.draw 1110, 510, 2
    end

    def update
      @mouse_x = mouse_x.to_i+30
      @mouse_y = mouse_y.to_i+10
      if @play.isHover(@mouse_x,@mouse_y)
        @play.color(Gosu::Color::YELLOW)
      elsif @play.getColor == Gosu::Color::YELLOW
        @play.color(Gosu::Color::CYAN)
      end
      if @credits.isHover(@mouse_x,@mouse_y)
        @credits.color(Gosu::Color::YELLOW)
      elsif @credits.getColor == Gosu::Color::YELLOW
        @credits.color(Gosu::Color::CYAN)
      end
      if @commandes.isHover(@mouse_x,@mouse_y)
        @commandes.color(Gosu::Color::YELLOW)
      elsif @commandes.getColor == Gosu::Color::YELLOW
        @commandes.color(Gosu::Color::CYAN)
      end
      if @exit.isHover(@mouse_x,@mouse_y)
        @exit.color(Gosu::Color::YELLOW)
      elsif @exit.getColor == Gosu::Color::YELLOW
        @exit.color(Gosu::Color::CYAN)
      end
      if @sound_btn.isHover(@mouse_x,@mouse_y)
        @sound_btn.color(Gosu::Color::YELLOW)
      elsif @sound_btn.getColor == Gosu::Color::YELLOW
        @sound_btn.color(Gosu::Color::CYAN)
      end
    end

    def button_down(id)
      @mouse_x = mouse_x.to_i+30
      @mouse_y = mouse_y.to_i+10
      case id
      when Gosu::MsLeft
        if @play.isHover(@mouse_x,@mouse_y)
          @music.stop
          self.close!
          Fenetre.new.show
        end
        if @credits.isHover(@mouse_x,@mouse_y)
          self.close!
          Credits.new.show
        end
        if @commandes.isHover(@mouse_x,@mouse_y)
          self.close!
          Commandes.new.show
        end
        if @exit.isHover(@mouse_x,@mouse_y)
          self.close!
        end
        if @sound_btn.isHover(@mouse_x,@mouse_y) && @music.playing?
          @music.pause
        elsif @sound_btn.isHover(@mouse_x,@mouse_y) && !@music.playing?
          @music.play(true)
        end
      end
    end
end

#TEST
# Création d'une fenêtre
window = MenuPrincipal.new

# Affichage
window.show
