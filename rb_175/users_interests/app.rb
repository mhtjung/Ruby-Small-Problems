=begin
Code Challenge
Problem: Create a Sinatra application that satisfies these requirements using what we've covered so far in this course.

Requirements:
  1. When a user loads the home page, they should see a page that list all user names
    - Each user name should be a link to a page for that user
  2. On each user page, display their email address
    - Also display their interests, with a comma appearing between interest
    - At the bottom of the page, display a list of links to all other users, except for the current user
  3. Add a layout to the application.
    - At the bottom of every page, display a message like this: "There are X users with a total of Y interests"
  4. Update the message printed out in requirement #3 to determine the number of users and interests, based on the YAML file.
    -  Use a helper method - count_interests, to determine the toal number of interests across all users.
  5. Add a new users.yaml file. Verify that the site updates accordingly.


Parts:
1. Create a ERB layout
  - Yield to a ERB view
  - Views:
    - Home page
    - User page
    - 404 (Maybe? Redirect to home)
2. Application Logic
  - Home Page
    - Load contents of YAML file into Ruby object
    - Parse YAML file into relevant HTML using .ERB file

=end
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "pry"
require "psych"

before do
  @userdata = Psych.load_file("users.yaml")
  @valid_users = @userdata.keys.map(&:to_s)
end

get "/" do
  @title = "Home Page"
  erb :home
end

get "/users" do
  redirect "/"
end

get "/users/:username" do |username|
  redirect "/" unless @valid_users.include? username
  @current_user = username.to_sym
  erb :user
end

not_found do
  redirect "/"
end

helpers do
  def count_interests
    num_users = @userdata.size
    num_interests = @userdata.map do |username, info|
      info[:interests].size
    end.sum
    "There are #{num_users} users with #{num_interests} interests"
  end
end