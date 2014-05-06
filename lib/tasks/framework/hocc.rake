# # Parse The Hospital of Central Connecticut providers
# namespace :framework do
#   desc "Scrape data about The Hospital of Central Connecticut providers"
#   task providers: :environment do
#     print "...Parsing The Hospital of Central Connecticut providers\n"
#     agent = Mechanize.new
#     base_hocc = "http://www.thocc.org/contact/specialties.aspx"
#     parse_page_hocc(base_hocc, agent)
#   end
# end

# # The Hospital of Central Connecticut
# def parse_page_hocc(url, agent)
#   hospital_name = "The Hospital of Central Connecticut"
#   page = agent.get(url)
#   items = page.search(".padded ul li b")
#   items[0..(items.length - 1)].each do |li|
#     if li.text != "-"
#       name = li.text
#       print "......Parsing #{name}..."
#       hospital = Hospital.find_by_name(hospital_name)
#       provider = Provider.find(name: name, hospital_id: hospital.id )
#       provider ||= Provider.create(name: name.titleize)
#       print "DONE\n"
#     end
#   end
#   print "...DONE\n"
# end