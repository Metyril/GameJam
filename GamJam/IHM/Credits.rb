require 'gosu'
require_relative './Bouton.rb'


class Credits < Gosu::Window
  def initialize(width=1280, height=720, options={:fullscreen => false})
    super
    self.caption = 'Omotecy - Crédits'
    @background = Gosu::Image.new('./media/menus/background2.png')
    @cursor = Gosu::Image.new('./media/menus/mouse.png')
    @retour = Bouton.new(10,10,350,80,Gosu::Color::CYAN,"Retour",3)

    @credits = Gosu::Image.from_text('Credits', 50, {:font => "./media/menus/Basica.ttf", :align => :center})
    @message = Gosu::Image.from_text('Thomas    Laurent    aka    Le    Modeleur', 30, {:font => "./media/menus/Basica.ttf"})
    @message2 = Gosu::Image.from_text('Jeremy    Martin          aka    Le    Musicien', 30, {:font => "./media/menus/Basica.ttf"})
    @message3 = Gosu::Image.from_text('Romain    Lascaux      aka    Le    MegaConcepteur', 30, {:font => "./media/menus/Basica.ttf"})
    @message4 = Gosu::Image.from_text('Clement    Martin      aka    Le    Minotaure', 30, {:font => "./media/menus/Basica.ttf"})
    @message5 = Gosu::Image.from_text('Jeremy    Andre           aka    Le    MultiDimensioneur', 30, {:font => "./media/menus/Basica.ttf"})
    @sources = Gosu::Image.from_text('Sources : ', 50, {:font => "./media/menus/Basica.ttf", :align => :center})
    @source_son = Gosu::Image.from_text('Bruitages                                       Universal    Soundbank', 30, {:font => "./media/menus/Basica.ttf"})
    @source_police = Gosu::Image.from_text('Police    Ecriture                     Basica    by    QbotypeFonts', 30, {:font => "./media/menus/Basica.ttf"})
    @source_glitch = Gosu::Image.from_text('Glitcher                                           ImageGlitcher', 30, {:font => "./media/menus/Basica.ttf"})
  end

  def draw
    @retour.draw
    @background.draw(0, 0, 0)
    @cursor.draw self.mouse_x, self.mouse_y, 4
    @credits.draw(475, 50, 0)
    @message.draw(200, 150, 0)
    @message2.draw(200, 200, 0)
    @message3.draw(200, 250, 0)
    @message4.draw(200, 300, 0)
    @message5.draw(200, 350, 0)
    @sources.draw(475,450,0)
    @source_son.draw(200,550,0)
    @source_police.draw(200,600,0)
    @source_glitch.draw(200,650,0)
  end

  def update
    @mouse_x = mouse_x.to_i+30
    @mouse_y = mouse_y.to_i+10
    if @retour.isHover(@mouse_x,@mouse_y)
        @retour.color(Gosu::Color::YELLOW)
    elsif @retour.getColor == Gosu::Color::YELLOW
        @retour.color(Gosu::Color::CYAN)
    end
end

  def button_down(id)
    @mouse_x = mouse_x.to_i+30
    @mouse_y = mouse_y.to_i+10
    case id
    when Gosu::MsLeft
      if @retour.isHover(@mouse_x,@mouse_y)
        self.close!
        MenuPrincipal.new.show
      end
    end
  end
end