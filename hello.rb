require 'sinatra'

get '/' do
  "Hello World!"
end

post '/java' do
  puts params.inspect
  puts params[:file]
  tmpfile = params[:file][:tempfile]
  directory = '/app'
  name = params[:file][:filename]
  path = File.join(directory, name)
  File.open(path, "wb") { |f| f.write(tmpfile.read) }
  `javac #{path}`
  puts `java #{name.split('.')[0]}`
end

