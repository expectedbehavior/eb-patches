require "test_helper"
require "active_support/core_ext/numeric/time"

class DatePatchTest < MiniTest::Unit::TestCase
  ###
  #  These are all big tests because you can't uninclude modules in
  #  ruby, even though you can undefine the methods they
  #  include. Integration tests! Fick jah!
  ###
  def test_before_patch
    assert !Date.today.respond_to?(:before?)
    assert_raises(NoMethodError) { Date.today.before? }

    Eb.monkey_patch Date, :before?
    today = Date.today

    assert today.before?(1.day.from_now)
    assert today.before?(Date.tomorrow)
    assert !today.before?(today)
    assert !today.before?(Date.yesterday)
    assert !today.before?(1.day.ago)
    assert !today.before?(1.second.from_now)
    assert !today.before?(1.second.ago)
  end

  def test_after_patch
    assert !Date.today.respond_to?(:after?)
    assert_raises(NoMethodError) { Date.today.after? }

    Eb.monkey_patch Date, :after?
    today = Date.today

    assert today.after?(Date.yesterday)
    assert today.after?(1.day.ago)

    assert !today.after?(1.day.from_now)
    assert !today.after?(Date.tomorrow)
    assert !today.after?(today)
    assert !today.after?(1.second.from_now)
    assert !today.after?(1.second.ago)
  end
end
