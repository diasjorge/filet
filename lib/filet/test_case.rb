require 'filet'
require 'filet/backport'

module Filet
  class TestCase < Filet.base_klass
    extend Filet::Backport::Declarative unless respond_to?(:test)

    class << self
      attr_accessor :description

      alias :scenario :test

      def context(name, options = {}, &block)
        klass = create_class(name, self, &block)

        Filet.context_hook.call(klass, options) if Filet.context_hook

        klass
      end

      # We don't want to redefine ActiveSupport::TestCase methods
      if respond_to?(:setup) && respond_to?(:teardown)
        alias :background :setup
      else
        def background(&block)
          define_method(:setup, &block)
        end

        def teardown(&block)
          define_method(:teardown, &block)
        end
      end

    end

    # Placeholder so test/unit ignores test cases without any tests.
    def default_test
    end
  end

  def feature(name, description, options = {}, &block)
    klass = create_class(name, Filet::TestCase, &block)
    klass.description = description

    Filet.feature_hook.call(klass, options) if Filet.feature_hook
    klass
  end

  private

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
