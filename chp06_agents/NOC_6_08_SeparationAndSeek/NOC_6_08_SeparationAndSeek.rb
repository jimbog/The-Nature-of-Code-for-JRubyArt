# The Nature of Code
# NOC_6_08_SeparationAndSeek
require_relative 'vehicle'

attr_reader :vehicles

def setup
  sketch_title 'Noc 6 08 Separation And Seek'
  @vehicles = Array.new(100) { Vehicle.new(rand(width), rand(height)) }
end

def draw
  background(255)
  vehicles.each do |v|
    v.apply_behaviors(vehicles)
    v.update
    v.borders(width, height)
    v.display
  end
end

def mouse_dragged
  vehicles << Vehicle.new(mouse_x, mouse_y)
end

def settings
  size(640, 360)
end

