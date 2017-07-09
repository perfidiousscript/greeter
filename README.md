# README

#### Sam Moss Greeter app JUL2017

## instructions

1. To run the app you will need to first install ruby version manager: https://rvm.io/

2. Clone the project and run '$ bundle install' in the command line, this will install all dependencies and should take 5-10 minutes.

3. Once you have everything installed run '$ rails s' to start the server.

4. Got to 'localhost:3000/greetings/new'. This will present a form that you can use to select the guest, company and alter the template.

5. Click the submit button and you will be sent to the display page, which will display your formatted greeting.

## design and language choices

  I wrote this as a very small Rails application because rails apps are what I

am most familiar with right now.

Writing the program as a Rails app introduced a bit of overhead,

but allowed for an easy GUI and eased a few other things.

I tried to follow MVC as closely as possible, and Rails makes this easy.

The most relevant files are 'app/controller/greetings_controller.rm',

'app/models/greeting.rb' and the 'app/views/greetings' folder.

Rails generally assumes that you have a db running,

but since that seemed unnecessary for this project I had to do some non-standard

stuff especially around pulling in the JSON files.

Normally each guest and customer would be instantiated as an instance of their

respective models and saved in the db,

allowing them to be searched et c. Since I could not save them to the db I was

forced to reread them from json each time I needed to use them.

This isn't a problem here, but would be slow with sufficiently large json files.

  I decided to put a check in for the four template values that were in the pdf

greeting, and allowed for two optional template values for lastName and the

Company city.

  I put in two routes for the greeting: /new and /display in an attempt to

follow REST.

This app could pretty easily be converted to a GUI-less API with the addition

of a few lines to the controllers.

## Code verification

  I wrote a test suite that runs a set of unit and feature tests. You can run

these tests yourself by running '$ rspec' in the command line.

Green dots are good, red dots are bad. Tests are located in the spec folder.
