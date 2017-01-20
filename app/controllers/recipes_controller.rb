get '/recipes/random' do
  @recipes = User.newyorktimes(rand(119).to_s)
  erb :'/recipes/show'
end
