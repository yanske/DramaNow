require 'test_helper'

class DramaTest < ActiveSupport::TestCase
  test "drama can only be created on supported sites" do
    invalid_site = "not_a_site_dot_com"
    refute_includes Drama::ACCEPTED_SITES, invalid_site
    
    drama_one = dramas(:one)
    drama_one.site = invalid_site
    refute drama_one.save
    assert_equal drama_one.errors.full_messages, ["Site is not included in the list"]
  end
  
  test "no duplicate dramas on same site can be saved" do
    drama_one = dramas(:one)
    dup_drama = drama_one.clone
    refute dup_drama.save
    assert_equal dup_drama.errors.full_messages, ["Title already exists in selected site"]
  end
end
