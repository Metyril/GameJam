require 'gosu'
#require 'auto_click'
require_relative 'projectModele.rb'
require_relative 'createModele.rb'

$WIDTH = 1000
$HEIGHT = 600

##$WIDTH = 1600
##$HEIGHT = 900

$MOUSEREFX = 800
$MOUSEREFY = 500
$DEMIPI = Math::PI/2

class Fenetre < Gosu::Window
  def initialize
    super $WIDTH , $HEIGHT, fullscreen: false
    @focus = true

    Triangle.setRefSize($WIDTH, $HEIGHT)

    @modele = CreateModele::sim
    @modele2 = CreateModele::cube
    @modele3 = CreateModele::tonneau 0.2
    @modele4 = CreateModele::pyramide

    @modeleCellule = CreateModele::cellule

    @camera = Camera.new

    @cameraHUD = Camera.new

    @zoom = 1

    @gangle = 0



    @listCellules = Array.new

    for i in (0..15)
      @listCellules.push(CreateModele::cellule(i.to_s(2).rjust(4, '0')))
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      if !@focus
        close
      else
        @focus = false
      end
    else
      @focus = true
    end
  end

  def update
    self.caption = "#{Gosu.fps} FPS / ZQSD, espace, ctrl et souris | double echap pour quitter"

    #angle = 0
    #dist = 0
    #if @focus
    #  angle = -Math.atan2($MOUSEREFX - cursor_position[0],  $MOUSEREFY - cursor_position[1])
    #  dist = Math.sqrt(($MOUSEREFX - cursor_position[0])**2 + ($MOUSEREFY - cursor_position[1])**2) * 0.005
    #  mouse_move($MOUSEREFX, $MOUSEREFY)
    #end

    frontal = 0
    lateral = 0

    frontal = -0.4 if Gosu.button_down? Gosu::KB_S
    frontal = 0.4 if Gosu.button_down? Gosu::KB_W
    lateral = -0.4 if Gosu.button_down? Gosu::KB_A
    lateral = 0.4 if Gosu.button_down? Gosu::KB_D

    @camera.position.y -= 0.2 if Gosu.button_down? Gosu::KB_E or Gosu.button_down? Gosu::KB_SPACE
    @camera.position.y += 0.2 if Gosu.button_down? Gosu::KB_Q or Gosu.button_down? Gosu::KB_LEFT_CONTROL

    @camera.rotation.x -= 0.02 if Gosu.button_down? Gosu::KB_UP
    @camera.rotation.x += 0.02 if Gosu.button_down? Gosu::KB_DOWN
    @camera.rotation.y -= 0.02 if Gosu.button_down? Gosu::KB_LEFT
    @camera.rotation.y += 0.02 if Gosu.button_down? Gosu::KB_RIGHT

    @camera.position.x += Math.sin(@camera.rotation.y) * frontal + Math.cos(-@camera.rotation.y) * lateral
    @camera.position.z += Math.cos(@camera.rotation.y) * frontal + Math.sin(-@camera.rotation.y) * lateral

    #@camera.rotation.x += Math.cos(angle) * dist
    #@camera.rotation.y += Math.sin(angle) * dist

    if @camera.rotation.x > $DEMIPI
      @camera.rotation.x = $DEMIPI
    elsif @camera.rotation.x < -$DEMIPI
      @camera.rotation.x = -$DEMIPI
    end



    if Gosu.button_down? Gosu::KB_O
      @zoom += 0.01
      Point.setZoom(@zoom)
    elsif Gosu.button_down? Gosu::KB_L
      @zoom -= 0.01
      Point.setZoom(@zoom)
    end
  end

  def draw
    for i in (1..8) do
      for j in (1..8) do
        for k in (1..8) do
          @modele.draw(@camera, i*6 + 5, j*6, k*6, @gangle*0.2 , @gangle, 0)
        end
      end
    end

    for i in (6..7) do
      for j in (1..2) do
        for k in (1..2) do
          @modele2.draw(@camera, i*3 + 5, j*4, k*3, -@gangle*2 , -@gangle, 0)
        end
      end
    end

    @gangle += 0.02
    @modele.draw(@camera, 0, 5, 0, 0, 0, 0)
    @modele.draw(@camera, 1, 0, 4, 0, 3.14, 0)

    @modele4.draw(@camera, -5, 0, 0, 0, 0, 0)

    @listCellules[1].draw(@camera, -20, 30, 0, 0, 0, 0)
    @listCellules[12].draw(@camera, -40, 30, 0, 0, 0, 0)
    @listCellules[10].draw(@camera, -40, 30, 20, 0, 0, 0)
    @listCellules[7].draw(@camera, -40, 30, 40, 0, 0, 0)
    @listCellules[1].draw(@camera, -20, 30, 40, 0, 0, 0)
    @listCellules[4].draw(@camera, -60, 30, 40, 0, 0, 0)

    Gosu::draw_rect(0, 0, $WIDTH, $HEIGHT, 0xff2c3e50, -999)
  end

  def needs_cursor?
    !@focus
  end

  #def needs_redraw?
    #true
  #end
end

Fenetre.new.show
