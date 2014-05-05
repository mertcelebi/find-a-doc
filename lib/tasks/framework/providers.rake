# Parse CT hospital providers
namespace :framework do
  desc "Scrape data about CT hospital providers"
  task providers: :environment do
    print "Parsing Backus Hospital...\n"
    agent = Mechanize.new
    base_url = "http://backushospital.org/find-a-doctor/?doctorSort=specialty"
    parse_page_backus(base_url, agent)
    print "DONE\n"
  end
end

# Goes through the url and parses data about
# CT hospital providers
def parse_page_backus(url, agent)
  hospital_name = "The William W. Backus Hospital"
  page = agent.get(url)
  items = page.search(".specialty_table")
  items[0..(items.length - 1)].each do |li|
    specialty = li.search("th").text
    el = li.search("tr td")
    name = el.search(".name").text
    print "...Parsing #{name}..."
    department = el.search(".department").text
    phone = el.search(".phone").text
    hospital = Hospital.find_by_name(hospital_name)
    provider = Provider.find(name: name, hospital_id: hospital.id )
    provider ||= Provider.create(name: name.titleize, 
                                 department: department,
                                 specialty: specialty)
                                 phone: phone)
    specialty = Specialty.find_by_name(name.titleize)
    specialty ||= Specialty.create(name: name.titleize, provider_id: provider.id)
    print "DONE\n"
  end
end