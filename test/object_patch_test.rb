require "test_helper"
require "pry"

#ActiveSupport 3.1.0+ adds this method for us, so let's undef it
Object.class_eval <<-END, __FILE__, __LINE__
  undef_method :in?
END

class ObjectPatchTest < MiniTest::Unit::TestCase
  ###
  #  These are all big tests because you can't uninclude modules in
  #  ruby, even though you can undefine the methods they
  #  include. Integration tests! Fick jah!
  ###
  def test_in_patch
    assert !Object.new.respond_to?(:in?)
    assert_raises(NoMethodError) { Object.new.in? }

    Eb.monkey_patch Object, :in?
    assert :b.in?(:a,:b)
    assert !:c.in?(:a,:b)

    assert [1,2].in?([1,2],[2,3])
    assert ![1,2].in?([1,3],[2,1])

    assert 1.in?([1,2])
    assert !3.in?([1,2])

    h = { "a" => 100, "b" => 200 }
    assert "a".in?(h)
    assert !"z".in?(h)

    assert "lo".in?("hello")
    assert !"ol".in?("hello")
    assert ?h.in?("hello")

    assert 25.in?(1..50)
    assert !75.in?(1..50)

    s = Set.new([1,2])
    assert 1.in?(s)
    assert !3.in?(s)

    assert_raises(ArgumentError) { 1.in?(1) }
  end
end
