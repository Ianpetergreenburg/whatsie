get '/users' do
  @users = User.all
  erb :'users/index'
end

get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users' do
  @user = User.create(params[:user])

  if @user.persisted?
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :'users/new'
  end
end
