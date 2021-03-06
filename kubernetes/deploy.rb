require 'faraday'
require 'json'

# This sleep is here to prevent the non-actualization of the cache
# on the docker side that would take the previous image to deployment.
sleep(5)

url = "https://registry.hub.docker.com/v2/repositories/virtuatable/frontend/tags"
body = JSON.parse(Faraday.get(url).body)
tags = body['results'].map { |i| i['name'].to_s }

content = File.read(File.join(__dir__, 'kubernetes.yml'))
content.gsub!('{{version}}', tags.max)

puts content