class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :new]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = current_user.tasks.all
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      flash[:success] = 'Success!'
      redirect_to @task
    else
      flash.now[:danger] = 'Failed'
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Success!'
      redirect_to @task
    else
      flash.now[:danger] = 'Failed...'
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy

    flash[:success] = '正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end
