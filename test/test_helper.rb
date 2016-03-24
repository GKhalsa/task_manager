ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'tilt/erb'

Capybara.app = TaskManagerApp

module TestHelpers
  def teardown  #runs after test apposed to setup
    task_manager.delete_all
    super  #what is super
  end

  def task_manager
    database = YAML::Store.new('db/task_manager_test')
    @task_manager ||= TaskManager.new(database)
  end

  def create_task(num = 2)
    num.times do |i|
      task_manager.create({
        :title => "This is a title #{i + 1}",
        :description => "This is a description #{i + 1}"
        })
    end
  end
end
