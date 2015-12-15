# Congressional Vote Tracker
This is the code that backs the [Twitter account for @congress247](https://twitter.com/congress247).  It retrieves publicly accessible data about votes in the U.S. Congress and tweets summaries about them.  It currently only reports on Senate votes.

## Setup
Clone the repo:

		git clone https://github.com/nevern02/vote_tracker.git

Make a local secrets file:

		cp config/secrets.yml.example config/secrets.yml

The `rake update` task does all the work of grabbing the latest vote data and turning it into tweets.

## Contributing
1. Fork it ( http://github.com/nevern02/vote_tracker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
