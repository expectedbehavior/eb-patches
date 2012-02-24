require "test_helper"

class FloatPatchTest < MiniTest::Unit::TestCase
  ###
  #  These are all big tests because you can't uninclude modules in
  #  ruby, even though you can undefine the methods they
  #  include. Integration tests! Fick jah!
  ###
  def test_the_float_patch
    assert !1.0.respond_to?(:approx)
    assert_raises(NoMethodError) { 1.0.approx(0) }


    Eb.monkey_patch Float, "approx"
    assert 1.0.respond_to?(:approx)
    assert (0.0000000000000000000000001).approx(0)
    assert !1.0.approx(0)
    assert !(-0.000002).approx(0)
  end
end
