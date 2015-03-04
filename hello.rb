require 'sinatra'

get '/' do
  "Hello World!"
end

post '/java' do
  puts params.inspect
  puts params[:file]
  
  
end

