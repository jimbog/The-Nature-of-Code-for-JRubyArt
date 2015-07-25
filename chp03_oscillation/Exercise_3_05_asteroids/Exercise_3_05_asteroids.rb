# Exercise_3_05_asteroids
# The Nature of Code
# http://natureofcode.com
# Chapter 3: Asteroids

class Spaceship

  def initialize(width, height)
    @location = Vec2D.new(width / 2, height / 2)
    @velocity = Vec2D.new
    @acceleration = Vec2D.new
    @damping = 0.995
    @topspeed = 6
    # Variable for heading!
    @heading = 0
    # Size
    @r = 16
    # Are we thrusting (to color boosters)
    @thrusting = false
  end

  # Standard Euler integration
  def update
    @velocity += @acceleration
    @velocity *= @damping
    @velocity.set_mag(@topspeed) {@velocity.mag > @topspeed}
    @location += @velocity
    @acceleration *= 0
  end

  # Newton's law: F = M * A
  def apply_force(force)
    #f = force.copy
    #f.div(mass); # ignoring mass right now
    @acceleration += force
  end

  # Turn changes angle
  def turn(a)
    @heading += a
  end

  # Apply a thrust force
  def thrust
    # Offset the angle since we drew the ship vertically
    angle = @heading - PI / 2
    # Polar to cartesian for force vector!
    force = Vec2D.new(cos(angle), sin(angle))
    force *= 0.1
    apply_force(force)
    # To draw booster
    @thrusting = true
  end

  def wrap_edges(width, height)
    buffer = @r * 2
    if @location.x > width +  buffer
      @location.x = -buffer
    elsif @location.x < -buffer
      @location.x = width+buffer
    end

    if @location.y > height + buffer
      @location.y = -buffer
    elsif @location.y < -buffer
      @location.y = height+buffer
    end
  end

  # Draw the ship
  def display
    stroke(0)
    stroke_weight(2)
    push_matrix
    translate(@location.x, @location.y + @r)
    rotate(@heading)
    fill(175)
    fill(255,0,0) if @thrusting
    # Booster rockets
    rect(-@r / 2, @r, @r / 3, @r / 2)
    rect(@r / 2, @r, @r / 3, @r / 2)
    fill(175)
    # A triangle
    begin_shape
    vertex(-@r, @r)
    vertex(0, -@r)
    vertex(@r, @r)
    end_shape(CLOSE)
    rect_mode(CENTER)
    pop_matrix
    @thrusting = false
  end
end

# Exercise_3_05_asteroids
def setup
  sketch_title 'Exercise 3 05 Asteroids'
  @ship = Spaceship.new(width, height)
end

def draw
  background(255)
  # Update location
  @ship.update
  # Wrap edges
  @ship.wrap_edges(width, height)
  # Draw ship
  @ship.display
  fill(0)
  text('left right arrows to turn, z to thrust', 10, height - 5)
end

def key_pressed
  if key == CODED && key_code == LEFT
    @ship.turn(-0.03)
  elsif key == CODED && key_code == RIGHT
    @ship.turn(0.03)
  elsif key == 'z' or key == 'Z'
    @ship.thrust
  end
end

def settings
  size(640, 360)
end

