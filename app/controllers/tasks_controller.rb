class TasksController < ApplicationController
  
  before_filter :load_collection, :only => 'index'
  before_filter :load_object,     :only => ['show', 'edit', 'toggle']
  
  private
  
  def load_collection
    if params[:project_id]
      @tasks = Project.find(params[:project_id]).tasks
    else
      @tasks = Task.all_ordered
    end
  end
  
  def load_object
    @task = Task.find(params[:id])
  end
  
  public
  
  # GET /tasks
  # GET /tasks.xml
  def index
    # @tasks = Task.all # Unordered
    @tasks = Task.all_ordered

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to(@task) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
  
  # Toggles between completed and uncompleted states
  def toggle
    if @task.toggle! :completed
      flash[:notice] = (@task.completed?) ? 'Task was completed' : 'Task was opened again' unless request.xhr?
    end
    respond_to do |format|
      format.html { redirect_to projects_path }
      format.js do
        render :update do |page|
          page.replace dom_id(@task), :partial => 'task', :object => @task
          page.visual_effect :highlight, dom_id(@task), :duration => 1.5, :delay => 0.3
        end
      end
    end    
  end
  
  # Toggles state for all tasks based on params[:completed] from checkbox values (non-Ajax only)
  # NOTE : params[:completed] holds IDs of tasks which should be set to completed
  def toggle_all
    redirect_to root_path if params[:completed].blank?
    @all = Task.all
    @completed = Task.find( params[:completed] )
    Task.transaction do
      # Update all tasks for which we have not received ID (= checkbox unchecked) to uncompleted
      Task.update_all( { :completed => false },  [ "id IN (?)", (@all - @completed).collect {|t| t.id} ]  )
      # Update all tasks for received IDs as completed
      Task.update_all( { :completed => true  },  [ "id IN (?)", params[:completed] ]  )
    end
    redirect_to projects_path
  end
  
  # Recently completed tasks
  def recent
    @tasks = Task.all_completed.recently_completed
    respond_to do |format|
      format.html { render :action => 'index' }
      format.atom #recent.atom.builder
    end
  end
  
end
