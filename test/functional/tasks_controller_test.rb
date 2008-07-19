require File.join( File.dirname(__FILE__), '..', 'test_helper' )

class TasksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_task
    assert_difference('Task.count') do
      post :create, :task => { :name => 'Test task', :due_on => Time.now }
    end
    assert_redirected_to task_path(assigns(:task))
  end

  def test_should_show_task
    get :show, :id => tasks(:milk).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => tasks(:milk).id
    assert_response :success
  end

  def test_should_update_task
    put :update, :id => tasks(:milk).id, :task => { :name => 'Changed name' }
    assert_redirected_to task_path(assigns(:task))
  end

  def test_should_destroy_task
    assert_difference('Task.count', -1) do
      delete :destroy, :id => tasks(:milk).id
    end
    assert_redirected_to tasks_path
  end
  
  def test_should_get_recent
    get :recent
    assert_response :success
    assert_not_nil assigns(:tasks)
    assert_equal assigns(:tasks), [tasks(:bread)]
  end
  
  def test_should_get_atom_feed
    get :recent, :format => 'atom'
    assert_response :success
    assert_not_nil assigns(:tasks)
    assert_equal assigns(:tasks), [tasks(:bread)]
  end
  
  def test_should_toggle_task_by_http
    post :toggle, :id => tasks(:milk)
    assert_response :redirect
    assert Task.find( tasks(:milk).id ).completed?
    assert Task.all_completed.include?( tasks(:milk) )
  end
  
  def test_should_toggle_task_by_ajax
    xhr :post, :toggle, :id => tasks(:milk)
    assert_response :success
    assert @response.body.to_s.include?("<li id=\\\"task_#{tasks(:milk).id}\\\" class=\\\"completed\\\">")
    assert Task.find( tasks(:milk).id ).completed?
    assert Task.all_completed.include?( tasks(:milk) )
  end
  
  def test_should_toggle_all
    post :toggle_all, :completed => [tasks(:milk), tasks(:presentation)]
    assert_response :redirect
    assert_redirected_to projects_path
    assert_equal Task.all_completed, [tasks(:milk), tasks(:presentation)]
  end
  
end
