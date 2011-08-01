require 'test/unit'
require 'filet'
require 'filet/backport'
require 'filet/hooks'

module Filet
  base_klass = Filet.rails? ? ActionController::IntegrationTest : Test::Unit::TestCase

  class TestCase < base_klass

    extend Filet::Hooks
    extend Filet::Backport::Declarative unless Filet.rails?

    class << self
      attr_accessor :description

      alias :scenario :test

      def context(name, options = {}, &block)
        klass = create_class(name, self, &block)

        context_hook.call(klass, options) if context_hook

        klass
      end

      def background(&block)
        define_method(:setup, &block)
      end

      def teardown(&block)
        define_method(:teardown, &block)
      end

    end

    # Placeholder so test/unit ignores test cases without any tests.
    def default_test
    end

  end

  def feature(name, description, options = {}, &block)
    klass = create_class(name, Filet::TestCase, &block)
    klass.description = description

    Filet::TestCase.feature_hook.call(klass, options) if Filet::TestCase.feature_hook
    klass
  end

  def create_class(name, superclass, &block)
    klass = Class.new(superclass)
    name = name.gsub(/(^\d*|\W)/, ' ').lstrip
    klass_name = name.gsub(/(^[a-z]|\s+\w)/).each do |match|
      match.lstrip.upcase
    end

    const = superclass.const_set klass_name, klass
    const.class_eval(&block) if block
    const
  end
end
