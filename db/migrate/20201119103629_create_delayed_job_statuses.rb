class CreateDelayedJobStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :delayed_job_statuses do |t|
      t.integer  "JobId",                                          :null => false
      t.integer  "Status"
      t.integer  "Priority"
      t.integer  "Attempts",                        :default => 0
      t.text     "Handler",                                        :null => false
      t.string   "Queue",             :limit => 60
      t.datetime "JobCompletionTime",                              :null => false
      t.datetime "JobRunTime"
      t.datetime "JobCreateTime"
      t.datetime "JobFailedTime"
      t.timestamps
    end
  end
end
