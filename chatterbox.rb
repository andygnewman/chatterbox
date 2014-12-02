# Things that could be improved
# better way of doing the user prompt & computer prompt that doesn't repeat so much


require 'yaml'
filename = 'responses.txt'

class String
  def red;            "\033[31m#{self}\033[0m" end
  def blue;           "\033[34m#{self}\033[0m" end
end 

def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  response.nil? ? new_response(input) : response % { c1: $1, c2: $2, c3: $3}
end

def new_response(input)
  puts "#{$computer_prompt} What response should I give to \"#{input}\"?".red
  print "User #{$name}:> ".blue
  new_answer = gets.chomp
  RESPONSES[input] = new_answer
  return "Thanks #{$name}, I have memorised \"#{new_answer}\" in response to \"#{input}\". Try me again."
end  

$computer_prompt = "Computer:>"

puts "#{$computer_prompt} Hello, what's your name?".red
print "Username:> ".blue
$name = gets.chomp
puts "#{$computer_prompt} Hello #{$name}".red
print "User #{$name}:> ".blue

RESPONSES = YAML::load_file filename

while(input = gets.chomp) do # need to colour the user input
  if input.downcase == 'quit'
    save_responses = RESPONSES.to_yaml
    File.open(filename, 'w') do |f|
      f.write(save_responses)
    end
    break
  end
  puts "#{$computer_prompt} #{get_response(input)}".red
  print "User #{$name}:> ".blue
end
