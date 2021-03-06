# NOC_3_07_oscillating_objects
# The Nature of Code
# http://natureofcode.com

require_relative 'oscillator'
attr_reader :oscillators

def setup
  sketch_title 'Oscillating Objects'
  @oscillators = Array.new(10) { Oscillator.new(max_x: width, max_y: height) }
end

def draw
  background 255
  oscillators.each do |o|
    o.oscillate
    o.display
  end
end

def settings
  size 800, 200
  smooth 4
end
