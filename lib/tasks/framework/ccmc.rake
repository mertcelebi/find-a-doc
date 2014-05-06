# Parse Connecticut Children's Medical Center providers
namespace :framework do
  desc "Scrape data about Connecticut Children's Medical Center providers"
  task ccmc: :environment do
    print "...Parsing Connecticut Children's Medical Center providers\n"
    agent = Mechanize.new
    base_ccmc = "http://www.connecticutchildrens.org/physicians/?alpha=a"
    parse_page_ccmc(base_ccmc, agent, 0)
  end
end

# Connecticut Children's Medical Center
def parse_page_ccmc(url, agent, depth)
  hospital_name = "Connecticut Children's Medical Center".titleize
  base = "http://www.connecticutchildrens.org/physicians/"
  page = agent.get(url)
  if depth == 0
    items = page.search(".letters-wrap .letter")
    items[0..(items.length - 1)].each do |li|
      link = base + li.search("a").first["href"]
      parse_page_ccmc(link, agent, depth + 1)
    end
  else
    items = page.search(".phys-search-content")
    items[0..(items.length - 1)].each do |li|
      name = li.search("h2 a").text.titleize
      spec = li.search(".phsy-search-spec a").first
      spec = spec.text.titleize unless spec.nil?
      print "......Parsing #{name}"
      hospital = Hospital.find_by_name(hospital_name)
      hid = hospital.id.to_s
      provider  = Provider.create(name: name, hospital_id: hid)
      pid = provider.id.to_s
      specialty = Specialty.create(name: spec, provider_id: pid)
      print "...DONE\n"
    end
    print "...DONE\n"
  end  
end