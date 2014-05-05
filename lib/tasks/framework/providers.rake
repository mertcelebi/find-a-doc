# Parse CT hospital providers
namespace :framework do
  desc "Scrape data about CT hospital providers"
  task providers: :environment do
    print "Parsing Backus Hospital...\n"
    agent = Mechanize.new
    base_url = "http://backushospital.org/find-a-doctor/?doctorSort=specialty"
    parse_page_backus(base_url, agent, 0)
    print "DONE\n"
  end
end

# Goes through the url and parses data about
# CT hospital providers
def parse_page_backus(url, agent, depth)
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