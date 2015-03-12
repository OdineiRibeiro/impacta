require 'sinatra'
require 'v8'
require 'execjs'

get '/' do
  erb :code
end

post '/js' do
  code = params[:code]
  context = ExecJS.compile("var ijs = #{code}")
  context.call('ijs')
end


post '/java' do
  `rm Teste.java Teste`
  code = params[:code]
  code = code.gsub('\r', ' ').gsub('\n', ' ').gsub('\t', ' ')
  puts code
  File.open('Teste.java', "wb") { |f| f.write(code) }
  `javac Teste.java`
  `java Teste`
end

post '/c' do
  code = params[:code]
  code = code.gsub('\r', ' ').gsub('\n', ' ').gsub('\t', ' ')
  puts code
  program_name  = [Time.now.to_i, (0..999).to_a.sample].map(&:to_s).join
  source_code = program_name + '.c'
  begin
    file = File.open(source_code, "w")
    file.write(code) 
  rescue IOError => e
    #some error occur, dir not writable etc.
  ensure
    file.close unless file == nil
  end
  `gcc -o #{program_name} #{source_code}`
  `./#{program_name}`
end

