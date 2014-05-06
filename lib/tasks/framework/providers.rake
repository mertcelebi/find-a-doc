# Parse CT hospital providers
namespace :framework do
  desc "Scrape data about CT hospital providers"
  task providers: :environment do
    agent = Mechanize.new
    base_greenwich = "http://www.greenhosp.org/Physicians/ResultsList.aspx?id=10&sid=1"
    parse_page_greenwich(base_greenwich, agent, 0)
  end
end

# Greenwich Hospital
def parse_page_greenwich(url, agent, depth)
  hospital_name = "Greenwich Hospital"
  base = "http://www.greenhosp.org/"
  page = agent.get(url)
    if depth == 0
      print "...Parsing Greenwich Hospital...\n"
      items = page.search(".docResultsList td")
      items[1..(items.length - 1)].each do |li|
        link = li.search("a").first
        print "#{link}\n"
        # parse_page_ccmc(link, agent, depth + 1)
      end
    else
      # items = page.search(".phsy-search-spec")
      # items[0..(items.length - 1)].each do |li|
      #   name = li.search("h2").text.split(",", 2).first
      #   print "......Parsing #{name}..."
      #   specialty = li.search("a").first.text
      #   hospital = Hospital.find_by_name(hospital_name)
      #   provider = Provider.find(name: name, hospital_id: hospital.id )
      #   provider ||= Provider.create(name: name.titleize, 
      #                                specialty: specialty.titleize)
      #   specialty = Specialty.find_by_name(name.titleize)
      #   specialty ||= Specialty.create(name: name.titleize, provider_id: provider.id)
      #   print "DONE\n"
      print "...DONE\n"
    end  
  end