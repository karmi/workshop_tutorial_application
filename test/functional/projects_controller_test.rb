require File.join( File.dirname(__FILE__), '..', 'test_helper' )

class ProjectsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
    assert_not_nil assigns(:projects)
    # Ensure we have two projects
    assert_equal assigns(:projects).size, 2
    # Ensure we have <li> tag with completed project in HTML
    assert_tag :tag => 'li', :attributes => { :id => "task_#{tasks(:bread).id}", :class => 'completed' }
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_project
    assert_difference('Project.count') do
      post :create, :project => { :name => 'Test project' }
    end

    assert_redirected_to projects_path
  end

  def test_should_show_project
    get :show, :id => projects(:office).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => projects(:office).id
    assert_response :success
  end

  def test_should_update_project
    put :update, :id => projects(:office).id, :project => { }
    assert_redirected_to projects_path
  end

  def test_should_destroy_project
    assert_difference('Project.count', -1) do
      delete :destroy, :id => projects(:office).id
    end

    assert_redirected_to projects_path
  end
end
