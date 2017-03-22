require 'benchmark'

get '/collect' do
  @recipes = []
  @times = []
  @total = Benchmark.measure {
    10.times do |i|
      length = @recipes.length
      url = "https://cooking.nytimes.com/recipes/#{i}"
      time = Benchmark.measure {
        @recipes.push url if url_exist?(url)
      }.real
      @recipes.push (i.to_s + ' doesn\'t exist') if length == @recipes.length
      @times.push time
    end
  }.real
  erb :'collection'
end
