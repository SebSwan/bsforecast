 env :PATH, ENV['PATH']
 set :output, "log/cron_log.log"
 set :runner_command, "rails runner"

  set :chronic_options, hours24: true

every 1.day, at: ['0:01', '6:01', '12:01', '18:01'] do
  runner "Windfinder.load_all(Spot.all)"
end

# every 1.minutes do

#   runner "Windfinder.test"
# end

# every 10.minutes do
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
# pth = Rails.root.join('cron_log.log').to_s
# set :output, "#{pth}"
