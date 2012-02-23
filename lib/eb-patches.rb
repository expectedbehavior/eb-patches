require "eb-patches/version"
require "eb-patches/float"

module Eb
  ###
  #  Usage:
  #    Eb.monkey_patch Float, "approx"
  #    -or-
  #    Eb.monkey_patch Float, :approx
  ###
  def Eb.monkey_patch(patch_target, method_name)
    camelized_method_name = method_name.gsub(/_/,' ').split.map(&:capitalize).join
    patch_module = "Eb::Patches::#{patch_target}::#{camelized_method_name}"

    ### this stolen from active support
    names = patch_module.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
    end
    ### end the stealing
    puts "#{patch_target} including #{constant}"
    patch_target.send :include, constant
  end
end
