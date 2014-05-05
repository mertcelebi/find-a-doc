# Parse CT hospital information
namespace :framework do
  desc "Scrape data about CT hospital"
  task hospitals: :environment do
    print "Parsing CT hospital names...\n"
    agent = Mechanize.new
    base_url = "http://www.chime.org/advocacy/employee-wellness/smoke-free-hospital-campus-initiative/the-william-w-backus-hospital/"
    parse_page_hospital(base_url, agent, 0)
    print "DONE\n"
  end
end

# Goes through the url and parses
# US state names
def parse_page_hospital(url, agent, depth)
  page = agent.get(url)
  if depth == 0
    base = "http://www.chime.org"
    items = page.search(".navSecondary li")
    items[0..(items.length - 1)].each do |li|
      link = base + li.search("a").first["href"]
      parse_page_hospital(link, agent, depth + 1)
    end
  else
    items = page.search(".locationPlace")
    items[0..(items.length - 1)].each do |li|
      name = li.search(".locationName").text
      print "...Parsing #{name}..."
      web = li.search(".locationStreetAddress").text
      phone = li.search(".locationTelephone").text.split(" ", 2).first
      hospital = Hospital.find_by_name(name.titleize)
      hospital ||= Hospital.create(name: name.titleize, 
                                   phone: phone,
                                   website: web)
      print "DONE\n"
    end
  end
end