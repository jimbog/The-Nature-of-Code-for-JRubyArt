# Exercise_3_11_AdditiveWave
# The Nature of Code
# http://natureofcode.com

# Additive Wave
# Create a more complex wave by adding two waves together.

def setup
  sketch_title 'Additive Wave Exercise'
  @w = width + 16    # Width of entire wave
  @xspacing = 8      #  How far apart should each horizontal location be spaced
  @maxwaves = 5      # total # of waves to add together
  @theta = 0.0
  @amplitudes = (0..@maxwaves).map {rand(10..30) }
  @dx = Array.new(@maxwaves) do |x|     # Value for incrementing X, to be calculated as a function of period and xspacing
    period = rand(100..300)            # How many pixels before the wave repeats
    (TWO_PI / period) * @xspacing
  end
  @yvalues = Array.new(@w / @xspacing)
end

def draw
  background(255)
  calc_wave
  render_wave
end

def calc_wave
  # Increment theta (try different values for 'angular velocity' here
  @theta += 0.02
  # Set all height values to zero
  @yvalues.each_index{ |i| @yvalues[i] = 0 }
  # Accumulate wave height values
  (0...@maxwaves).each do |j|
    x = @theta
    @yvalues.each_index do |i|
      # Every other wave is cosine instead of sine
      if j.even?
        @yvalues[i] += sin(x) * @amplitudes[j]
      else
        @yvalues[i] += cos(x) * @amplitudes[j]
      end
      x += @dx[j]
    end
  end
end

def render_wave
  # A simple way to draw the wave with an ellipse at each location
  stroke(0)
  fill(127, 50)
  ellipse_mode(CENTER)
  @yvalues.each_with_index { |yvalue, idx| ellipse(idx * @xspacing, height / 2 + yvalue, 48, 48) }
end

def settings
  size(750, 200)
end
