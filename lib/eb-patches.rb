module Eb
  ###
  #  Usage:
  #    Eb.monkey_patch Float, "approx"
  #    -or-
  #    Eb.monkey_patch Float, :approx
  ###
  def Eb.monkey_patch(patch_target, method_name)
    require_active_support_string_helpers
    require_patch_file_for_class(patch_target)
    patch_module = module_to_include(patch_target, method_name)
    patch_target.send :include, patch_module
  end

  def Eb.down_under(string)
    string.strip.gsub(/\s/, "_").gsub(/\W/, "").underscore.downcase
  end

  def Eb.require_active_support_string_helpers
    require "active_support/core_ext/string/inflections"
  end

  def Eb.require_patch_file_for_class(klass)
    require "eb-patches/#{down_under(klass.to_s)}"
  end

  def Eb.module_to_include(patch_target, method_name)
    module_name = submodule_name(patch_target, method_name)
    module_name.constantize
  end

  def Eb.submodule_name(patch_target, method_name)
    "Eb::Patches::#{patch_target}::#{modulize_method_name(method_name)}"
  end

  def Eb.modulize_method_name(name)
    name.to_s.gsub(/_/,' ').gsub(/[?!]/,'').split.map(&:capitalize).join
  end
end
