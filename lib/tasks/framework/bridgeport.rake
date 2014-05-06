# # Parse Bridgeport Hospital providers
# namespace :framework do
#   desc "Scrape data about Bridgeport Hospital providers"
#   task providers: :environment do
#     print "...Parsing Bridgeport Hospital providers\n"
#     agent = Mechanize.new
#     base_bridgeport = "http://www.bridgeporthospital.org/FindPhysician/default.aspx?view=list&sort=alpha"
#     parse_page_bridgeport(base_bridgeport, agent)
#   end
# end

# # Bridgeport Hospital
# def parse_page_bridgeport(url, agent)
#   base = "http://www.bridgeporthospital.org/FindPhysician/default.aspx?view="
#   hospital_name = "Bridgeport Hospital"
#   page = agent.get(url)
#   items = page.search(".specialty_table")
#   items[0..(items.length - 1)].each do |li|
#     specialty = li.search("th").text
#     el = li.search("tr td")
#     name = el.search(".name").text
#     print "......Parsing #{name}..."
#     department = el.search(".department").text
#     phone = el.search(".phone").text
#     hospital = Hospital.find_by_name(hospital_name)
#     provider = Provider.find(name: name, hospital_id: hospital.id )
#     provider ||= Provider.create(name: name.titleize, 
#                                  department: department,
#                                  specialty: specialty.titleize,
#                                  phone: phone)
#     specialty = Specialty.find_by_name(name.titleize)
#     specialty ||= Specialty.create(name: name.titleize, provider_id: provider.id)
#     print "DONE\n"
#   end
#   print "...DONE\n"
# end