require "test_helper"

class StringPatchTest < MiniTest::Unit::TestCase
  ###
  #  These are all big tests because you can't uninclude modules in
  #  ruby, even though you can undefine the methods they
  #  include. Integration tests! Fick jah!
  ###
  def test_methodize_patch
    assert !"foo".respond_to?(:methodize)
    assert_raises(NoMethodError) { "foo".methodize }

    Eb.monkey_patch String, :methodize
    assert_equal "foo",     "foo".methodize
    assert_equal "foo_bar", "foo Bar ".methodize
    assert_equal "foo",     " foo \t\n".methodize
    assert_equal "foo",     "Foo".methodize
    assert_equal "f_oo",    "fOo".methodize
    assert_equal "foo_bar", "FooBar".methodize
  end

  def test_down_under_patch
    assert !"foo".respond_to?(:down_under)
    assert_raises(NoMethodError) { "foo".down_under }

    Eb.monkey_patch String, :down_under
    assert_equal "foo",     "foo".down_under
    assert_equal "foo_bar", "foo Bar ".down_under
    assert_equal "foo",     " foo \t\n".down_under
    assert_equal "foo",     "Foo".down_under
    assert_equal "f_oo",    "fOo".down_under
    assert_equal "foo_bar", "FooBar".down_under
  end

  def test_filename_sanitize_patch
    assert !"foo".respond_to?(:filename_sanitize)
    assert_raises(NoMethodError) { "foo".filename_sanitize }

    Eb.monkey_patch String, :filename_sanitize
    assert_equal "test.txt", "C:\\Windows\\FUUU\\test.txt".filename_sanitize
    assert_equal "test.txt", "C:\\Windows\\FUUU &\\test.txt".filename_sanitize
    assert_equal "te_t.txt", "C:\\Windows\\FUUU\\te&t.txt".filename_sanitize
    assert_equal "te_t.txt", "C:\\Windows\\FUUU\\te_t.txt".filename_sanitize
    assert_equal "te-t.txt", "C:\\Windows\\FUUU\\te-t.txt".filename_sanitize
    assert_equal "te_t.txt", "C:\\Windows\\FUUU\\te t.txt".filename_sanitize
    assert_equal "test.txt", "/usr/lib/src/test.txt".filename_sanitize
    assert_equal "test.txt", "/usr/lib/src &/test.txt".filename_sanitize
    assert_equal "te_t.txt", "/usr/lib/src/te&t.txt".filename_sanitize
    assert_equal "te_t.txt", "/usr/lib/src/te_t.txt".filename_sanitize
    assert_equal "te-t.txt", "/usr/lib/src/te-t.txt".filename_sanitize
    assert_equal "te_t.txt", "/usr/lib/src/te t.txt".filename_sanitize
  end
end
