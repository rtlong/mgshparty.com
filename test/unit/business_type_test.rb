require 'test_helper'

class BusinessTypeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert BusinessType.new.valid?
  end
end
