require_relative "../test_helper"
require 'pry'

class TestHelperTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_task
    task_manager.create({
      :title => "title",
      :description => "task description"
      })

    task = task_manager.find(1)

    assert_equal "title", task.title
    assert_equal "task description", task.description
    assert_equal 1, task.id
  end

  def test_it_has_raw_tasks
    task_manager.create({
      :title => "title",
      :description => "task description"
      })
      binding.pry
    assert_equal "title", task_manager.database['tasks'][0]['title']
    assert_equal "task description", task_manager.database['tasks'][0]['description']
  end

  def test_it_can_locate_all
    task_manager.create({
      :title => "title",
      :description => "task description"
      })
    task_manager.create({
      :title => "title",
      :description => "task description"
      })

    assert_equal 2, task_manager.all.count
  end

  def test_it_can_find_by_id
    task_manager.create({
      :title => "title",
      :description => "task description"
      })
    task_manager.create({
      :title => "titleeee",
      :description => "task description"
      })

    task = task_manager.find(2)
    assert_equal "titleeee", task.title
  end

  def test_it_can_update
    task_manager.create({
      :title => "title",
      :description => "task description"
      })

    task = task_manager.find(1)
    assert_equal "title", task.title

    task_manager.update({
      :title => "titleeeee",
      :description => "task description"
      }, 1)

    task = task_manager.find(1)
    assert_equal "titleeeee", task.title
  end

  def test_it_can_destroy_by_id
    task_manager.create({
      :title => "title",
      :description => "task description"
      })

    task = task_manager.find(1)
    assert task

    task_manager.destroy(1)
    task = task_manager.find(1)
    refute task
  end

  def create_tasks(num = 2)
    num.times do |i|
      task_manager.create({
        :title => "title #{i + 1}",
        :description => "task description #{i + 1}"
        })
    end
  end

end
