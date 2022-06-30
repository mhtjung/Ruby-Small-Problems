require 'psych'

test = Psych.load_file('users.yaml')
username = :jamy

p test[:jamy][:email]