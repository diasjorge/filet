module Filet
  module Integration
    def base_klass
      @@filet_base_klass ||=
        # rails 3
        if defined?(ActionDispatch)
          require 'action_dispatch/testing/integration'
          ActionDispatch::IntegrationTest
        # rails 2
        elsif defined?(ActionController)
          ActionController::IntegrationTest
        elsif defined?(ActiveSupport)
          require 'active_support/test_case'
          ActiveSupport::TestCase
        else
          require 'test/unit/testcase'
          Test::Unit::TestCase
        end
    end

    def base_klass=(klass)
      @@filet_base_klass = klass
    end
  end

  extend Integration
end
