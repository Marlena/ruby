require 'rubygems'
require 'net/http'
require 'json'
 
jira_url = "http://jira.atlassian.com/rest/api/latest/issue/"
issue_keys = %w[TST-6410 TST-2165 TST-4104]
json_ext = ".json"
 
for issue in issue_keys
 
    response = Net::HTTP.get_response(URI.parse(jira_url + issue + json_ext))
 
    if response.code =~ /20[0-9]{1}/
        data = JSON.parse(response.body)
        fields = data.keys
 
        puts "Output for issue " + issue
     
        puts "issue reporter: "
        puts data["fields"]["reporter"]["value"].values[0]
 
        puts "issue summary: "
        puts data["fields"]["summary"].values[1]
 
        puts "issue description: "
        puts data["fields"]["description"].values[1]
 
        #uncomment the two lines below to see a prettified version of the json
        #puts "Here is prettified JSON data: "
        #puts JSON.pretty_generate(data)
        #
        puts "\n"#extra line feed for readability
    else
     raise StandardError, "Unsuccessful response code " + response.code + " for issue " + issue
    end
end
