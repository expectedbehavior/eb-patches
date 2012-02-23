module Eb::Patches::Float
  module Approx
    # Is a float within the EPSILON value of the Float base class?
    # use: (0.0000000000000000000000001).approx(0) => probably true
    # use: (-0.000002).approx(0) => false
    def approx(other, relative_epsilon=::Float::EPSILON, epsilon=::Float::EPSILON)
      difference = other - self
      return true if difference.abs <= epsilon
      relative_error = (difference / (self > other ? self : other)).abs
      relative_error <= relative_epsilon
    end
  end
end
