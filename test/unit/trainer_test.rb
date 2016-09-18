require 'test_helper'

class TrainerTest < MiniTest::Test
  def setup
    capture_subprocess_io do
      # temp in-memory db for testing ActiveRecord objects
      ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
      ActiveRecord::Migrator.migrate("db/migrate/")
    end

    ActiveRecord::Base.expects(:establish_connection).returns(true)
  end

  def test_train_prompts_cli_when_there_are_untrained_training_logs
    training_log = TrainingLog.create(
      root_domain: 'example.com',
      uri: 'example.com/article'
    )
    Trainer.expects(:cli_train).with(training_log)

    capture_subprocess_io do
      Trainer.train(domain: 'example.com')
    end
  end

  def test_train_finds_first_untrained_training_log_if_no_domain_specified
    training_log = TrainingLog.create(
      root_domain: 'example.com',
      uri: 'example.com/article'
    )
    Trainer.expects(:cli_train).with(training_log)

    capture_subprocess_io do
      Trainer.train
    end
  end

  def test_train_can_query_and_step_through_multiple_training_logs
    expected_logs = [
      TrainingLog.create(root_domain: 'example1.com', uri: 'example1.com/article'),
      TrainingLog.create(root_domain: 'example2.com', uri: 'example2.com/article')
    ]

    Trainer.expects(:cli_train).with(expected_logs[0])
    Trainer.expects(:cli_train).with(expected_logs[1])

    capture_subprocess_io do
      Trainer.train(count: 2)
    end
  end

  def test_train_does_not_prompt_for_claimed_or_trained_training_logs
    TrainingLog.create( root_domain: 'example.com', uri: 'example.com/article', trained_status: 'claimed')
    TrainingLog.create( root_domain: 'example.com', uri: 'example.com/article', trained_status: 'trained')

    TrainingLog.expects(:cli_train).never

    capture_subprocess_io do
      Trainer.train
    end
  end
end
