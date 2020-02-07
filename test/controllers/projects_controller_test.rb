require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  
  test "should show post" do
    get project_path(projects(:one))
    assert_response :success
  end

  test "updating a project" do
    test_login_as(users(:one), "secret")
    project = users(:one).projects.first
    patch project_path(project), params: { project: { name: "Editing proj", url: "https://awesomeproject.com" } }
    assert_redirected_to project
    assert_equal Project.find(project.id).name, "Editing proj"
    assert_equal 'Project was successfully updated.', flash[:notice]
  end

  test "creating a project" do
    test_login_as(users(:one), "secret")
    assert_difference("Project.count", 1) do
      post projects_path, params: { project: { name: "New proj", url: "https://awesomeproject.com" } }
    end
    assert_redirected_to Project.find_by(name: "New proj")
    assert_equal 'Project was successfully created.', flash[:notice]
  end

  test "deleting a project" do
    test_login_as(users(:one), "secret")
    project = users(:one).projects.first

    delete project_path(project)

    assert_redirected_to users(:one)
    assert_equal flash[:notice], "Project deleted"
  end


  test "create and new post should be restricted to logged in user" do

    get new_project_url
    assert_redirected_to "/login" 
    assert_equal flash[:error], "Please login first"

    assert_difference("Project.count", 0) do
      post posts_url, params: { project: { name: "This is a project!", description: "code blocks" } }
    end

    assert_redirected_to "/login"
    assert_equal flash[:error], "Please login first"
  end

  test "different user cannot edit someone else's post" do
    test_login_as(users(:malory), "sedscret")
    project = users(:one).projects.first

    get edit_project_path(project)
    assert_equal flash[:error], "You don't have the permissions to edit that project."
    assert_redirected_to project

    patch project_path(project), params: { project: { description: "Agar", description: "I shouldn't be allowed to edit this proj"}}
    assert_equal flash[:error], "You don't have the permissions to edit that project."
    assert_redirected_to project
  end
end
