#launch and initialise whenever task

task :start_whenever do
  sh "whenever"
   sh "bundle exec whenever --update-crontab"
   puts "cron activate"
end
