# Parse Backus Hospital providers
namespace :framework do
  desc "Scrape data about Backus Hospital providers"
  task backus: :environment do
    print "...Parsing Backus Hospital providers\n"
    agent = Mechanize.new
    base_backus = "http://backushospital.org/find-a-doctor/?doctorSort=last"
    parse_page_backus(base_backus, agent)
  end
end

# Backus Hospital
def parse_page_backus(url, agent)
  hospital_name = "The William W. Backus Hospital".titleize
  page = agent.get(url)
  items = page.search(".span_24 table tr")
  items[0..(items.length - 1)].each do |li|
    name = li.search(".name").text.titleize
    spec = li.search(".department").text.titleize
    if !(name.blank?)
      print "......Parsing #{name}"
      hospital = Hospital.find_by_name(hospital_name)
      hid = hospital.id.to_s
      provider  = Provider.create(name: name, hospital_id: hid)
      pid = provider.id.to_s
      specialty = Specialty.create(name: spec, provider_id: pid)
      print "...DONE\n"
    end
  end
  print "...DONE\n"
end