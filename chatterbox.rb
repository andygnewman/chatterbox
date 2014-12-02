def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  response.nil? ? 'sorry?' : response % { c1: $1, c2: $2}
end

RESPONSES = { 'goodbye' => 'bye', 
              'sayonara' => 'sayonara', 
              'hello' => 'hello yourself, how about saying something more interesting',
              'what\'s your name?' => 'my name is not important',
              'how are you feeling?' => 'I\'m a computer, I don\'t have feelings',
              'I\'m bored' => 'sorry, am I boring you?',
              'did you see the game at the weekend?' => 'no, but I hear it was a good one',
              'the weather is (.*)' => 'I hate it when it\'s %{c1}', 
              'I love (.*)' => 'I love %{c1} too', 
              'I groove to (.*) and (.*)' => 'I love %{c1} but I hate %{c2}',
              'my favourite football team is (.*)' => 'I think that %{c1} are pants, Brentford are much better',
              'I hate (.*) and (.*)' => 'Do you? I think %{c1} and %{c2} are pretty good',
              'today is the (.*) day of (.*)' => 'suprising that %{c2} should have a %{c1} day'}

puts "Hello, what's your name?"
name = gets.chomp
puts "Hello #{name}"
while(input = gets.chomp) do
  if input.downcase == 'quit'
    break
  end
  puts get_response(input)
end