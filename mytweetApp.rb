require "rubygems"
require "twitter"


# Certain methods require authentication. To get your Twitter OAuth credentials,
# register an app at http://dev.twitter.com/apps

YOUR_CONSUMER_KEY = "fI53hreh5tW2NhTtfngEQ"
YOUR_CONSUMER_SECRET = "XiOH9rqpmtISnJDvVwLeDbm3MmVjYU91oFcBsDkqMK8"
YOUR_OAUTH_TOKEN = "33058079-R6ifdmZLV8mr21SKs1rY99ZtGTaTaBxeWbUvoUmSc"
YOUR_OAUTH_TOKEN_SECRET = "2KdoQT57qgE2OEDJlMlpJ27VBqmSSm2gdACGI1pI"
Twitter.configure do |config|
  config.consumer_key = YOUR_CONSUMER_KEY
  config.consumer_secret = YOUR_CONSUMER_SECRET
  config.oauth_token = YOUR_OAUTH_TOKEN
  config.oauth_token_secret = YOUR_OAUTH_TOKEN_SECRET
end

# Initialize  Twitter client

client = Twitter::Client.new
search = Twitter::Search.new

while(1) do
	puts "type the apt NUMBER for action.. then press ENTER"
	puts " 1. Show the location of a user"
	puts " 2. Show the latest tweet from a user"
	puts " 3. Search any keyword "
	puts " 4. Update Status"
	puts " 5. Get the latest tweets from homepage"
	puts " 6. quit"
	a = gets

	case a.to_i
	when 1 
		# Get a user's location
		puts "Enter the UserId of the person whose location you are looking for"
		u = gets
		puts Twitter.user(u[0,u.length-1]).location
		print "\n \n"

	when 2
		# Get a user's most recent status update
		puts "Enter the userID of the person for whose latest status you want to see"
		u= gets
		puts Twitter.user_timeline(u[0,u.length-1]).first.text
		print "\n\n"
	
	when 3 
		puts "Enter the keyword you want to search for"
		u = gets
		search.containing(u).result_type("recent").per_page(3).each do |r|
		puts "#{r.from_user}: #{r.text}"
		print "\n\n"
		end
		search.clear
		print "\n\n"
	when 4 
		puts "what do you want to tweet"
		u = gets
		client.update(u)
		print "\n\n"

	when 5
		client.home_timeline.each do |r| 
		puts "#{r.from_user}: #{r.text}"
		print "\n\n"
		end

	when 6 
		puts "Please wait..  :P"
		break

	else
		puts"enter the correct option"
	end	

end

# Get your rate limit status
puts client.rate_limit_status.remaining_hits.to_s + " Twitter API request(s) remaining this hour"

