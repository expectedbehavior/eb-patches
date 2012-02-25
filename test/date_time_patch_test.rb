require "test_helper"
require "active_support/core_ext/numeric/time"

class DateTimePatchTest < MiniTest::Unit::TestCase
  ###
  #  These are all big tests because you can't uninclude modules in
  #  ruby, even though you can undefine the methods they
  #  include. Integration tests! Fick jah!
  ###
  def test_before_patch
    # sometimes date will load the patch first because of minitest
    # testing in random order. So, we just let it handle the patching
    # in that case
    unless (DateTime.included_modules.include?(Eb::Patches::Date::Before))
      assert !DateTime.now.respond_to?(:before?)
      assert_raises(NoMethodError) { DateTime.today.before? }

      Eb.monkey_patch DateTime, :before?
    end

    now = DateTime.now

    assert now.before?(1.day.from_now)
    assert now.before?(Date.tomorrow)
    assert now.before?(1.second.from_now)

    assert !now.before?(now)
    assert !now.before?(Date.yesterday)
    assert !now.before?(1.day.ago)
    assert !now.before?(1.second.ago)
  end

  def test_after_patch
    # sometimes date will load the patch first because of minitest
    # testing in random order. So, we just let it handle the patching
    # in that case
    unless (DateTime.included_modules.include?(Eb::Patches::Date::After))
      assert !DateTime.now.respond_to?(:after?)
      assert_raises(NoMethodError) { DateTime.today.after? }

      Eb.monkey_patch DateTime, :after?
    end

    now = DateTime.now

    assert now.after?(Date.yesterday)
    assert now.after?(1.day.ago)
    assert now.after?(1.second.ago)

    assert !now.after?(1.day.from_now)
    assert !now.after?(Date.tomorrow)
    assert !now.after?(now)
    assert !now.after?(1.second.from_now)
  end
end
