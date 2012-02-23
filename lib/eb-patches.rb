require "eb-patches/version"
require "eb-patches/float"
require "eb-patches/string"
require "active_support/core_ext/string/inflections"

module Eb
  ###
  #  Usage:
  #    Eb.monkey_patch Float, "approx"
  #    -or-
  #    Eb.monkey_patch Float, :approx
  ###
  def Eb.monkey_patch(patch_target, method_name)
    camelized_method_name = method_name.to_s.gsub(/_/,' ').split.map(&:capitalize).join
    patch_module = "Eb::Patches::#{patch_target}::#{camelized_method_name}"
    patch_target.send :include, patch_module.constantize
  end

  def Eb.down_under(string)
    string.strip.gsub(/\s/, "_").gsub(/\W/, "").underscore.downcase
  end
end
