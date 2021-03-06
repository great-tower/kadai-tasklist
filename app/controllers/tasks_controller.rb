class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:succes] = 'Taskが正常に保存されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが保存されませんでした'
      render :new
    end
    
  end
  
  def edit
  end
  
  def update

    if @task.update(task_params)
      flash[:succes] = 'Taskが正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが更新されませんでした'
      render :edit
    end
    
  end
  
  def destroy
    @task.destroy
    
    flash[:succes] = "正常に削除されました"
    redirect_to tasks_url
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
