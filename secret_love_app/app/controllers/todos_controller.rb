class TodosController < ApplicationController
    get "/todos" do
      if signed_in?
        @user = User.find(session[:user_id])
          @todos = Todo.where(user_id: current_user)
          erb :"todos/index.html"
      else
        redirect "/signin"
      end
    end
  
    get "/todos/new" do
      if signed_in?
        @user = User.find_by(id: session[:user_id])
        erb :"/todos/new.html"
      else
        redirect "/signin"
      end
    end
  
    # POST: /todos --- done
    post "/todos" do
      # raise params.inspect
      #params {"chore"=>"raise params inspect"}
      if signed_in?
        @user = User.find(session[:user_id])
        # binding.pry
  
        if params[:chore].empty?
          redirect "/todos/new"
        else
          @user = User.find_by(:id => session[:user_id])
          # create new instance of todo
          @todo = Todo.new
          # set the name of chore
          @todo.chore = params[:chore]
          # finally save it
          @todo.user_id = @user.id
          @todo.save
  
          redirect "/todos"
        end
      else
        redirect "/signin"
      end
    end
    get '/todos/:id' do
      if signed_in?
        # @user = User.find_by(id: session[:user_id])
        @todo = Todo.find(params[:id])
        if @todo && @todo.user == current_user
        # binding.pry
        erb :'/todos/show.html'
      else
        redirect "/signin"
      end
      else
        redirect '/signin'
      end
    end
    # GET: /todos/5
    get "/todos/:id/edit" do
      @user = User.find_by(id: session[:user_id])
      @todo = Todo.find(params[:id])
      if @todo && @todo.user == current_user
  
      erb :"/todos/edit.html"
      else
        redirect "/todos"
      end
    end
    patch '/todos/:id' do
      if signed_in?
        if params[:chore].empty?
          redirect "/todos/#{params[:id]}/edit"
        else
          @todo = Todo.find_by_id(params[:id])
          if @todo && @todo.user == current_user
            if @todo.update(:chore => params[:chore])
              redirect to "/todos/#{@todo.id}"
            else
            redirect to "/todos/#{@todo.id}/edit"
            end
          else
            redirect to '/todos'
          end
        end
      else
        redirect '/signin'
      end
    end
  
    delete '/todos/:id/delete' do
     if signed_in?
       @user = User.find_by(id: session[:user_id]) if session[:user_id]
       @todo = Todo.find_by_id(params[:id])
       # binding.pry
       if @todo && @todo.user == current_user
         @todo.delete
         redirect '/todos'
       end
     else
       redirect to '/signin'
     end
   end
  end
  