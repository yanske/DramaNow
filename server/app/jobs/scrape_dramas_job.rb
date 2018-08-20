require 'nokogiri'
require "watir"

class ScrapeDramasJob < ApplicationJob
  queue_as :default

  def perform(*args)
    active_dramas = Drama.active
    active_dramas.each do |drama| 
      doc = open_browser(drama.link)

      case drama.site
      when Drama::DRAMAFEVER
        latest_episode = parse_dramafever_site(doc)
        update_drama(latest_episode, drama)
      end
    end
  end

  private

  def open_browser(url)
    browser = Watir::Browser.new(:chrome, headless: true)
    browser.goto(url)
    Nokogiri::HTML.parse(browser.html)
  end

  def parse_dramafever_site(doc)
    # Check which one's value contains "TOTAL_EPISODES"
    content = doc.css('h5').detect do |elem|
      elem.values.include?("TOTAL_EPISODES")
    end&.children&.text

    return 0 if content.nil?

    # Expected: "## episodes"
    space_index = content.index(' ')
    return content[0..space_index - 1].to_i
  end

  def update_drama(latest_episode, drama)
    if latest_episode > drama.latest_episode
      drama.update!(latest_episode: latest_episode)
    end
  end
end
