# # Parse Backus Hospital providers
# namespace :framework do
#   desc "Scrape data about Backus Hospital providers"
#   task backus: :environment do
#     print "...Parsing Backus Hospital providers\n"
#     agent = Mechanize.new
#     base_backus = "http://backushospital.org/find-a-doctor/?doctorSort=specialty"
#     parse_page_backus(base_backus, agent)
#   end
# end

# # Backus Hospital
# def parse_page_backus(url, agent)
#   hospital_name = "The William W. Backus Hospital"
#   page = agent.get(url)
#   items = page.search(".specialty_table")
#   items[0..(items.length - 1)].each do |li|
#     specialty = li.search("th").text
#     # print "#{specialty}\n"
#     el = li.search("tr td")
#     el[0..0].each do |fin|
#       name = el.search(".name a")
#       print "#{name.text}\n"  
#       print "+++++++++++++++++++++++++++++\n"
#     end
#     # el[0..(el.length - 1)].each do |fin|
#     #   name = fin.search(".name").text
#     #   print "......Parsing #{fin}...\n"
#     #   department = el.search(".department").text
#     #   phone = el.search(".phone").text
#     # end
#     # hospital = Hospital.find_by_name(hospital_name)
#     # provider = Provider.find(name: name, hospital_id: hospital.id )
#     # provider ||= Provider.create(name: name.titleize, 
#     #                              department: department,
#     #                              specialty: specialty,
#     #                              phone: phone)
#     # specialty = Specialty.find_by_name(name.titleize)
#     # specialty ||= Specialty.create(name: name.titleize, provider_id: provider.id)
#     # print "DONE\n"
#   end
#   print "...DONE\n"
# end