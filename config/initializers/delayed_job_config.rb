# Customization for delayed_job

# Delayed::Worker.destroy_failed_jobs = true
# Delayed::Worker.sleep_delay = 60
  Delayed::Worker.max_attempts = 1
# Delayed::Worker.max_run_time = 5.minutes
# Delayed::Worker.read_ahead = 10
# Delayed::Worker.default_queue_name = 'default'
# Delayed::Worker.delay_jobs = !Rails.env.test?
# Delayed::Worker.raise_signal_exceptions = :term
Delayed::Worker.delay_jobs = !%w[ test ].include?(Rails.env)
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))

