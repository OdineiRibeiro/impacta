require 'sinatra'
require 'v8'

get '/' do
  "Faculdade Impacta de Tecnologia"
end

get '/code' do
  
  erb :code
end

post '/js' do
  cxt = V8::Context.new
  js_code = 'function(){ console.log("teste"); };'
  js = cxt.eval(js_code)
  js.to_s
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
  `java #{name.split('.')[0]}`
end

