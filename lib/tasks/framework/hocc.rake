# Parse The Hospital of Central Connecticut providers
namespace :framework do
  desc "Scrape data about The Hospital of Central Connecticut providers"
  task hocc: :environment do
    print "...Parsing The Hospital of Central Connecticut providers\n"
    agent = Mechanize.new
    base_hocc = "http://www.thocc.org/contact/specialties.aspx"
    parse_page_hocc(base_hocc, agent)
  end
end

# The Hospital of Central Connecticut
def parse_page_hocc(url, agent)
  hospital_name = "The Hospital of Central Connecticut".titleize
  page = agent.get(url)
  items = page.search(".padded ul li")
  items[1..(items.length - 1)].each do |li|
    name = li.search("b").text.squeeze(" ").strip.titleize
    if name != " "
      spec = li.text.split("Specializes in ", 2).last.split(" Need", 2).first.squeeze(" ").strip.titleize
      print "......Parsing #{name}..."
      hospital = Hospital.find_by_name(hospital_name)
      hid = hospital.id.to_s
      provider  = Provider.create(name: name, hospital_id: hid)
      pid = provider.id.to_s
      specialty = Specialty.create(name: spec, provider_id: pid)
      print "DONE\n"
    end
  end
  print "...DONE\n"
end