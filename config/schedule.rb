# job_type :rbenv_rake, %Q{export PATH=/opt/rbenv/shims:/opt/rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
#                          cd :path && bundle exec rake :task --silent :output }

# # env :PATH, '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin' 
# # set :env_path,    '"$HOME/.rbenv/shims":"$HOME/.rbenv/bin"'

set :output, { error: 'log/error.log', standard: 'log/cron_log.log' }
set :environment, "development"

# set :output, "log/cron_log.log"
# env :PATH, ENV['PATH']

every :wednesday, at: '5:05pm' do
  rake 'send_newsletter_email'
end
