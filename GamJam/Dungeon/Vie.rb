require 'gosu'

require_relative './Element.rb'

class Vie < Element
  def initialize(room)
    super room, CreateModele::croix, 3
  end

end
