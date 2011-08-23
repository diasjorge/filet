require 'test_helper'

module Filet
  class TestCaseTest < Test::Unit::TestCase
    def test_feature_returns_filet_test_case
      klass = feature("feature name", "feature description lorem ipsum")
      assert_equal Filet::TestCase, klass.superclass
      assert_equal "Filet::TestCase::FeatureName", klass.name
      assert_equal "feature description lorem ipsum", klass.description
    end

    def test_context_returns_feature_subclass
      klass = nil
      feature("feature name", "description") do
        klass = context("acceptance criteria 1")
      end

      assert_match /FeatureName::AcceptanceCriteria1$/, klass.name
      assert_match /FeatureName$/, klass.superclass.name
    end

    def test_provides_a_hook_to_process_feature_options
      Filet.feature_hook do |base, options|
        base.instance_variable_set("@feature_hook_on", true)
      end

      klass = feature("feature name", "description")

      assert klass.instance_variable_get("@feature_hook_on"), "hook is not used"

      Filet.feature_hook = nil
    end

    def test_provides_a_hook_to_process_context_options
      Filet.context_hook do |base, options|
        if options[:js]
          base.instance_variable_set("@js_option", true)
        end
      end

      klass = nil

      feature("feature name", "description") do
        klass = context("acceptance criteria js", :js => true)
      end

      assert klass.instance_variable_get("@js_option"), "hook is not used"

      Filet.context_hook = nil
    end

    def test_class_nesting_names
      context_klass = context_klass2 = nil

      feature("feature name", "description") do
        context("some context") do
          context_klass = context("the criteria")
        end

        context("other context") do
          context_klass2 = context("the criteria")
        end
      end

      assert_not_equal context_klass.name, context_klass2.name
    end

    def test_background_method
      klass = feature("feature name", "description") do
        background do
          klass.instance_variable_set("@setup_created", true)
        end
      end

      klass.new('default_test').setup
      assert klass.instance_variable_get('@setup_created')
    end

    def test_teardown_method
      klass = feature("feature name", "description") do
        teardown do
          klass.instance_variable_set("@teardown_created", true)
        end
      end

      klass.new('default_test').teardown
      assert klass.instance_variable_get('@teardown_created')
    end

    def test_scenario
      context_klass = nil

      klass = feature("feature name", "description") do
        scenario "Scenario description"

        context_klass = context "Grouping context" do
          scenario "Nested Scenario"
        end
      end

      assert klass.method_defined?("test_Scenario_description")
      assert context_klass.method_defined?("test_Nested_Scenario")
    end

    def teardown
      Filet::TestCase.send(:remove_const, :FeatureName) if defined?(Filet::TestCase::FeatureName)
    end
  end
end
