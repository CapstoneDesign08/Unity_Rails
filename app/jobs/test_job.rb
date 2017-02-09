class TestJob < ApplicationJob
  include ActiveJob::TrafficControl::Throttle

  throttle threshold: 5, period: 10.second, drop: false
  # 넣어줄 특정 큐 이름
  queue_as :test_queue

  def perform(*id)
    # 실행할 작업

  end

end
