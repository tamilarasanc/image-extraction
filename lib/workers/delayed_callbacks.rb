 module DelayedCallBacks

    def success job
      save_completed_job job
    end

    def error(job, exception)
      Rails.logger.info "Error for #{job.id} With Exception #{exception}"
    end

    def failure(job)
      Rails.logger.info "Save Failed Job #{job.id}"
      @job_id = DelayedJobStatus.maximum(:JobId)
      if @job_id == nil
        @job_id = 0
      else
        @job_id += 1
      end
      job.failed_at = job.failed_at || Time.now
      save_failed_job job
    end

    private

    def save_completed_job job
      DelayedJobStatus.create({
                                  Priority: job.priority,
                                  Attempts: job.attempts,
                                  Handler: job.handler,
                                  JobRunTime: job.run_at,
                                  JobCompletionTime: DateTime.now,
                                  Queue: job.queue,
                                  JobCreateTime: job.created_at,
                                  Status: 1,
                                  JobId: @job_id
                              })
    end

    def save_failed_job job
      DelayedJobStatus.create({
                                  Priority: job.priority,
                                  Attempts: job.attempts,
                                  Handler: job.handler,
                                  JobRunTime: job.run_at,
                                  Queue: job.queue,
                                  JobCompletionTime: DateTime.now,
                                  #TenantID: job.TenantID,
                                  JobFailedTime: job.failed_at,
                                  JobCreateTime: job.created_at,
                                  Status: 0,
                                  JobId: @job_id
                              })
    end

  end
