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
  puts "Computer:> What response should I give to \"#{input}\"?".red # need to use variable for computer prompt here
  print "User:> ".blue # need to add name into the prompt here
  new_answer = gets.chomp
  RESPONSES[input] = new_answer
  return "I have remembered the response of \"#{new_answer}\" to \"#{input}\". Try me again."
end  

#RESPONSES = { 'goodbye' => 'bye', 
#              'sayonara' => 'sayonara', 
#              'hello' => 'hello yourself, how about saying something more interesting',
#              'what\'s your name?' => 'my name is not important',
#              'how are you feeling?' => 'I\'m a computer, I don\'t have feelings',
#              'I\'m bored' => 'sorry, am I boring you?',
#              'did you see the game at the weekend?' => 'no, but I hear it was a good one',
#              'the weather is (.*)' => 'I hate it when it\'s %{c1}', 
#              'I love (.*)' => 'I love %{c1} too', 
#              'I groove to (.*) and (.*)' => 'I love %{c1} but I hate %{c2}',
#              'my favourite football team is (.*)' => 'I think that %{c1} are pants, Brentford are much better',
#              'I hate (.*) and (.*)' => 'Do you? I think %{c1} and %{c2} are pretty good',
#              'today is the (.*) day of (.*)' => 'suprising that %{c2} should have a %{c1} day',
#              'my three favourite things are (.*), (.*) and (.*)' => 'I like %{c1} and %{c2}, but not %{c3}',
#              'in the morning the first three things I do are (.*), (.*) and (.*)' => 'as a computer I can\'t %{c1}, %{c2} and %{c3}'}

computer_prompt = "Computer:>"

puts "#{computer_prompt} Hello, what's your name?".red
print "Username:> ".blue
name = gets.chomp
puts "#{computer_prompt} Hello #{name}".red

print "User #{name}:> ".blue  # need to refactor this as repeated

RESPONSES = YAML::load_file filename

while(input = gets.chomp) do # need to colour the user input
  if input.downcase == 'quit'
    # at this point need to export the current RESPONSES hash to the external file overwriting existing version
    save_responses = RESPONSES.to_yaml
    File.open(filename, 'w') do |f|
      f.write(save_responses)
    end
    # end of code to write the file
    break
  end
  puts "#{computer_prompt} #{get_response(input)}".red
  print "User #{name}:> ".blue
end
