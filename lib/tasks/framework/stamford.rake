# Parse Stamford Hospital providers
namespace :framework do
  desc "Scrape data about Stamford Hospital providers"
  task stamford: :environment do
    print "...Parsing Stamford Hospital providers\n"
    agent = Mechanize.new
    base_stamford = "http://www.stamfordhospital.org/Find-a-Doctor/Doctor-Search-Results.aspx?s=%7c0%7c0%7c0%7c0"
    process_page_stamford(base_stamford, agent)
    print "...DONE\n"
  end
end

def process_page_stamford(url, agent)
  hospital_name = "Stamford Hospital".titleize
  page = agent.get(url)
  rows = page.search(".searchListWrap tr")
  rows[1.(rows.length - 1)].each do |tr|
    name = tr.search(".PhysicianName h2").text.squeeze(" ").strip.titleize
    spec = tr.search(".Specialities ul span").text.squeeze(" ").strip.titleize
    print "......Parsing #{name}"
    hospital = Hospital.find_by_name(hospital_name)
    hid = hospital.id.to_s
    provider  = Provider.create(name: name, hospital_id: hid)
    pid = provider.id.to_s
    specialty = Specialty.create(name: spec, provider_id: pid)
    print "...DONE\n"
  end
end