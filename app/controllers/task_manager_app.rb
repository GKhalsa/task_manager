class TaskManagerApp < Sinatra::Base

  get '/' do
    erb :dashboard
  end

  get '/tasks' do  #read
    @tasks = task_manager.all
    erb :index
  end

  get '/tasks/new' do  #create
    erb :new
  end

  post '/tasks' do     #create
    task_manager.create(params[:task])
    redirect '/tasks'
  end

  get '/tasks/:id' do |id|  #read
    @task = task_manager.find(id.to_i)
    erb :show
  end

  get '/tasks/:id/edit' do |id|
    @task = task_manager.find(id.to_i)
    erb :edit
  end

  put '/tasks/:id' do |id|
    task_manager.update(params[:task], id.to_i)
    redirect "/tasks/#{id}"
  end

  delete '/tasks/:id' do |id|
    task_manager.destroy(id.to_i)
    redirect '/tasks'
  end

  not_found do
    erb :error
  end



  # def task_manager
  #   database = YAML::Store.new('db/task_manager')
  #   @task_manager ||= TaskManager.new(database)
  # end

  def task_manager
   if ENV["RACK_ENV"] == "test"
      database = YAML::Store.new('db/task_manager_test')
   else
      database = YAML::Store.new('db/task_manager')
   end
   @task_manager ||= TaskManager.new(database)
end

end
