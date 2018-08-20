require 'test_helper'

class ScrapeDramasJobTest < ActiveJob::TestCase
  setup do
    @drama = dramas(:one).dup
    Drama.destroy_all
  end

  test "scrapes dramafever sites" do
    @drama.site = Drama::DRAMAFEVER
    @drama.latest_episode = 1
    @drama.link = "https://www.dramafever.com/drama/5195/28/legend-of-fuyao-/"
    @drama.save!

    ScrapeDramasJob.perform_now
    assert_equal @drama.reload.latest_episode, 66
  end
end
