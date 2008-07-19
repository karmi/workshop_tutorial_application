require File.join( File.dirname(__FILE__), '..', 'test_helper' )

class ProjectTest < ActiveSupport::TestCase

  def test_project_should_have_proper_tasks
    assert_equal projects(:office), tasks(:presentation).project
  end

end
