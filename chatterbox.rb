require 'yaml'
require 'bundler/setup'
require 'colorize'

filename = 'responses.txt'

def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  response.nil? ? new_response(input) : response % { c1: $1, c2: $2, c3: $3}
end

def new_response(input)
  computer_prompt
  puts "What response should I give to \"#{input}\"?".colorize(:red)
  user_prompt
  new_answer = gets.chomp
  RESPONSES[input] = new_answer
  return "Thanks #{$name}, I have memorised \"#{new_answer}\" in response to \"#{input}\". Try me again."
end  

def user_prompt
  print "User #{$name}:> ".colorize(:blue)
end 

def computer_prompt
print "Computer:> ".colorize(:red)
end

computer_prompt
puts "Hello, what's your name?".colorize(:red)
print "Username:> ".colorize(:blue)
$name = gets.chomp
computer_prompt
puts "Hello #{$name}".colorize(:red)
user_prompt

RESPONSES = YAML::load_file filename

while(input = gets.chomp) do
  if input.downcase == 'quit'
    save_responses = RESPONSES.to_yaml
    File.open(filename, 'w') do |f|
      f.write(save_responses)
    end
    break
  end
  computer_prompt
  puts "#{get_response(input)}".colorize(:red)
  user_prompt
end
