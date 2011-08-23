require 'test_helper'
require 'active_support/test_case'

class ActiveSupportIntegrationTest < Test::Unit::TestCase
  def setup
    Filet.base_klass = nil
  end

  def test_base_klass
    assert_equal ActiveSupport::TestCase, Filet.base_klass
  end
end
