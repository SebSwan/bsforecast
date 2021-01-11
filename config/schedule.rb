 env :PATH, ENV['PATH']
 set :output, "log/cron_log.log"
 set :runner_command, "rails runner"

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
# pth = Rails.root.join('cron_log.log').to_s
# set :output, "#{pth}"

set :chronic_options, hours24: true

every 10.minutes do
   runner "Windfinder.load_all(Spot.all)"
end
# Example:
#
every 1.minutes do # 1.minute 1.day 1.week 1.month 1.year is also supported
  # the following tasks are run in parallel (not in sequence)
  runner "Windfinder.test"
end


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


# every 1.day, at: ['0:01' ,'2:15' '6:01', '12:01', '18:01'] do
# Learn more: http://github.com/javan/whenever
