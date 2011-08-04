require "filet/version"
require "filet/hooks"
require "filet/integration"

module Filet
  def self.included(base)
    require "filet/test_case"
  end
end

