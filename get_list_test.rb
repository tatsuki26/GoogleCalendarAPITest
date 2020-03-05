require 'google/api_client'
require 'time'
# require 'dotenv'

# Initialize OAuth 2.0 client
# authorization

client = Google::APIClient.new(application_name: '')
# Dotenv.load
client.authorization.client_id = ENV['CLIENT_ID']
client.authorization.client_secret = ENV['CLIENT_SECRET']
client.authorization.scope = ENV['SCOPE']
client.authorization.refresh_token = ENV['REFRESH_TOKEN']
client.authorization.access_token = ENV['ACCESS_TOKEN']

cal = client.discovered_api('calendar', 'v3')

printf('カレンダーを表示する年(20XX)：')
year = gets.strip.to_i
printf('カレンダーを表示する月(1-12)：')
month = gets.strip.to_i

# place the time from user
time_min = Time.utc(year, month, 1, 0).iso8601
time_max = Time.utc(year, month, 31, 0).iso8601

# get the event
params = { 'calendarId' => 'primary',
           'orderBy' => 'startTime',
           'timeMax' => time_max,
           'timeMin' => time_min,
           'singleEvents' => 'True' }

result = client.execute(api_method: cal.events.list,
                        parameters: params)
# place the event
events = result.data.items

# puts
events.each do |event|
  printf("%s,%s,%s\n", event.start.dateTime, event.end.dateTime, event.summary)
end