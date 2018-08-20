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

  test "link_to_episode returns correct link for dramafever sites" do
    drama_one = dramas(:one)
    drama_one.update!(link: 'https://www.dramafever.com/drama/123/28/slug-me/')
    assert_equal drama_one.link_to_episode(10),
      "https://www.dramafever.com/drama/123/10/slug-me/"
  end

  test "active scope returns dramas with latest episode updated within 35 days" do
    drama_one = dramas(:one)
    drama_one.update_column(:latest_episode_update, 30.days.ago)

    drama_two = dramas(:two)
    drama_two.update_column(:latest_episode_update, 40.days.ago)
    
    assert_equal Drama.active.map(&:id), [drama_one.id]
  end
end
