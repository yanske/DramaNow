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
    dup_drama = drama_one.dup
    refute dup_drama.save
    assert_equal dup_drama.errors.full_messages, ["Title already exists in selected site"]
  end

  test "modifying latest_episode automatically sets the timestamp" do
    drama_one = dramas(:one)
    time = 2.days.from_now

    Timecop.freeze(time) do
      drama_one.update!(latest_episode: 100)
      assert_equal drama_one.latest_episode_update.to_i, time.to_i
    end
  end

  test "modifying fields not latest_episode does not sets the timestamp" do
    drama_one = dramas(:one)
    time = 2.days.from_now

    Timecop.freeze(time) do
      drama_one.link = "123"
      drama_one.save!
      refute_equal drama_one.latest_episode_update.to_i, time.to_i
    end
  end
end
