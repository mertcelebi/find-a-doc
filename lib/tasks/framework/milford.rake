# Parse Windham Hospital providers
namespace :framework do
  desc "Scrape data about Milford Hospital providers"
  task milford: :environment do
    print "...Parsing Milford Hospital providers\n"
    agent = Mechanize.new
    base_milford = "http://www.milfordhospital.org/medical-services/clinical-services/staff-physicians/"
    process_page_milford(base_milford, agent)
    print "...DONE\n"
  end
end

def process_page_milford(url, agent)
  hospital_name = "Milford Hospital".titleize
  page = agent.get(url)
  rows = page.search(".physicians li")
  rows[0..(rows.length - 2)].each do |li|
    name = li.search("h4").text
    print "......Parsing #{name}"
    hospital = Hospital.find_by_name(hospital_name)
    hid = hospital.id.to_s
    provider  = Provider.create(name: name, hospital_id: hid)
    print "...DONE\n"
  end
end