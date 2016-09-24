require 'active_record'

class TrainingLog < ActiveRecord::Base
  validates :uri, uniqueness: true
  validates :trained_status, inclusion: { in: %w(untrained claimed trained), message: "%{value} is not a valid trained status" }

  class << self
    def mark_claimed(log)
      where(root_domain: log.root_domain).update(trained_status: 'claimed')
    end

    def mark_trained(log)
      where(root_domain: log.root_domain).update(trained_status: 'trained')
    end
  end
end
