require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.every '4h' do
  ScrapeDramasJob.perform_now
end
