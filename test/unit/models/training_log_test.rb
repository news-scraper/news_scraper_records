require 'test_helper'

class TrainingLogTest < MiniTest::Test
  def setup
    capture_subprocess_io do
      # temp in-memory db for testing ActiveRecord objects
      ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
      ActiveRecord::Migrator.migrate("db/migrate/")
    end

    @training_log = TrainingLog.create(
      root_domain: 'example.com',
      uri: 'example.com/article',
      trained_status: 'untrained'
    )
  end

  def test_mark_claimed_sets_trained_status_as_claimed
    TrainingLog.mark_claimed(@training_log)

    assert_equal 'claimed', @training_log.reload.trained_status
  end

  def test_mark_trained_sets_trained_status_as_trained
    TrainingLog.mark_trained(@training_log)

    assert_equal 'trained', @training_log.reload.trained_status
  end
end
