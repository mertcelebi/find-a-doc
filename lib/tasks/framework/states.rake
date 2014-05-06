# Parse US state names
namespace :framework do
  desc "Scrape data about US states"
  task states: :environment do
    print "Parsing State names...\n"
    agent = Mechanize.new
    base_url = "http://www.50states.com/"
    parse_page_states(base_url, agent)
    print "DONE\n"
  end
end

# Goes through the url and parses
# US state names
def parse_page_states(url, agent)
  page = agent.get(url)
  items = page.search(".listStates .floatLeft ul li a")
  items[0..49].each do |li|
    name = li.text.titleize
    print "...Parsing #{name}..."
    state = State.create(name: name)
    print "DONE\n"
  end
end