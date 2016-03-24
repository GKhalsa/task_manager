require_relative "../test_helper"
require 'pry'

class UserCanUpdateATaskTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_update_a_task
    create_task(1)
    task = task_manager.find(1)
    assert_equal "This is a title 1", task.title
    assert_equal "This is a description 1", task.description
    visit '/'
    click_link("Task Index")
    assert_equal "/tasks", current_path
    click_link "Edit"
    assert_equal "/tasks/1/edit", current_path
    fill_in "task[title]", with: "New Title"
    fill_in "task[description]", with: "New Description"
    save_and_open_page
    find('input[value="Submit"]').click
    task = task_manager.find(1)
    assert_equal "New Title", task.title
    assert_equal "New Description", task.description
  end

end
