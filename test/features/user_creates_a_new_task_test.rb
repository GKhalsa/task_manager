require_relative "../test_helper"

class UserCreatesANewTaskTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_create_a_task
    visit "/"
    click_link("New Task")
    assert_equal "/tasks/new", current_path
    fill_in "task[title]", with: "This is a task"
    fill_in "task[description]", with: "This is a description"
    click_button('Submit')
    assert_equal "/tasks", current_path
    task = task_manager.find(1)
    assert_equal "This is a task", task.title
    assert_equal "This is a description", task.description
  end


end
