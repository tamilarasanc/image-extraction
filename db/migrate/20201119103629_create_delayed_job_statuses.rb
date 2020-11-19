class CreateDelayedJobStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :delayed_job_statuses do |t|
      t.integer  :JobId
      t.integer  :Status
      t.integer  :Priority
      t.integer  :Attempts
      t.text     :Handler
      t.string   :Queue
      t.datetime :JobCompletionTime
      t.datetime :JobRunTime
      t.datetime :JobCreateTime
      t.datetime :JobFailedTime
      t.timestamps
    end
  end
end
