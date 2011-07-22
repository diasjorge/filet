module Filet
  def rails?
    defined?(ActionController)
  end

  extend self
end

require "filet/version"
require "filet/test_case"
