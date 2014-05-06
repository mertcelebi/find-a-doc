# Parse The Charlotte Hungerford Hospital providers
namespace :framework do
  desc "Scrape data about The Charlotte Hungerford Hospital providers"
  task chh: :environment do
    print "...Parsing The Charlotte Hungerford Hospital providers\n"
    agent = Mechanize.new
    num_pages = 200
    (1..num_pages).each do |page|
      base_chh = "http://www.charlottehungerford.org/physicians/searchable-md-database/?phys_id=#{page.to_s}"
      process_page_chh(base_chh, agent)
    end
    print "...DONE\n"
  end
end

def process_page_chh(url, agent)
  hospital_name = "The Charlotte Hungerford Hospital".titleize
  page = agent.get(url)
  rows = page.search(".entry-content")
  rows[0..(rows.length - 1)].each do |tr|
    name = tr.search("span strong").text.titleize
    spec = tr.search("h3 strong span").text.titleize
    if name != " , "
      print "......Parsing #{name} #{spec}"
      hospital = Hospital.find_by_name(hospital_name)
      hid = hospital.id.to_s
      provider  = Provider.create(name: name, hospital_id: hid)
      pid = provider.id.to_s
      specialty = Specialty.create(name: spec, provider_id: pid)
      print "...DONE\n"
    end    
  end
end