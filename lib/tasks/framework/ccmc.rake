# # Parse Connecticut Children's Medical Center providers
# namespace :framework do
#   desc "Scrape data about Connecticut Children's Medical Center providers"
#   task providers: :environment do
#     print "...Parsing Connecticut Children's Medical Center providers\n"
#     agent = Mechanize.new
#     base_ccmc = "http://www.connecticutchildrens.org/physicians/?alpha=a"
#     parse_page_ccmc(base_ccmc, agent, 0)
#   end
# end

# # Connecticut Children's Medical Center
# def parse_page_ccmc(url, agent, depth)
#   hospital_name = "Connecticut Children's Medical Center"
#   base = "http://www.connecticutchildrens.org/physicians/"
#   page = agent.get(url)
#   if depth == 0
#     items = page.search(".letters-wrap .letter")
#     items[0..(items.length - 1)].each do |li|
#       link = base + li.search("a").first["href"]
#       parse_page_ccmc(link, agent, depth + 1)
#     end
#   else
#     items = page.search(".phsy-search-spec")
#     items[0..(items.length - 1)].each do |li|
#       name = li.search("h2").text.split(",", 2).first
#       print "......Parsing #{name}..."
#       specialty = li.search("a").first.text
#       hospital = Hospital.find_by_name(hospital_name)
#       provider = Provider.find(name: name, hospital_id: hospital.id )
#       provider ||= Provider.create(name: name.titleize, 
#                                    specialty: specialty.titleize)
#       specialty = Specialty.find_by_name(name.titleize)
#       specialty ||= Specialty.create(name: name.titleize, provider_id: provider.id)
#       print "DONE\n"
#     end
#     print "...DONE\n"
#   end  
# end