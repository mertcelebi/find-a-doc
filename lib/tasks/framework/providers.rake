# Parse CT hospital providers
namespace :framework do
  desc "Scrape data about CT hospital providers"
  task providers: :environment do
    print "Parsing CT hospital providers...\n"
    agent = Mechanize.new
    # base_backus = "http://backushospital.org/find-a-doctor/?doctorSort=specialty"
    # parse_page_backus(base_backus, agent)
    # base_bridgeport = "http://backushospital.org/find-a-doctor/?doctorSort=specialty"
    # parse_page_bridgeport(base_bridgeport, agent)
    # base_bristol = "http://www.bristolhospital.org/find-a-doctor.aspx" Bristol dead-end
    # parse_page_bristol(base_bristol, agent)
    # base_hocc = "http://www.thocc.org/contact/specialties.aspx"
    # parse_page_hocc(base_hocc, agent)
    # base_ccmc = "http://www.connecticutchildrens.org/physicians/?alpha=a"
    # parse_page_ccmc(base_ccmc, agent, 0)
    base_greenwich = "http://www.greenhosp.org/Physicians/ResultsList.aspx?id=10&sid=1"
    parse_page_greenwich(base_greenwich, agent, 0)
    print "DONE\n"
  end
end

# Backus Hospital
# def parse_page_backus(url, agent)
#   print "...Parsing Backus Hospital...\n"
#   hospital_name = "The William W. Backus Hospital"
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
#                                  specialty: specialty,
#                                  phone: phone)
#     specialty = Specialty.find_by_name(name.titleize)
#     specialty ||= Specialty.create(name: name.titleize, provider_id: provider.id)
#     print "DONE\n"
#   end
#   print "...DONE\n"
# end

# Bridgeport Hospital
# def parse_page_bridgeport(url, agent)
#   base = "http://www.bridgeporthospital.org/FindPhysician/default.aspx?view="
#   print "...Parsing Backus Hospital...\n"
#   hospital_name = "The William W. Backus Hospital"
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
#                                  specialty: specialty.titleize)
#                                  phone: phone)
#     specialty = Specialty.find_by_name(name.titleize)
#     specialty ||= Specialty.create(name: name.titleize, provider_id: provider.id)
#     print "DONE\n"
#   end
#   print "...DONE\n"
# end

# The Hospital of Central Connecticut
# def parse_page_hocc(url, agent)
#   print "...Parsing The Hospital of Central Connecticut...\n"
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

# Connecticut Children's Medical Center
# def parse_page_ccmc(url, agent, depth)
#   hospital_name = "Connecticut Children's Medical Center"
#   base = "http://www.connecticutchildrens.org/physicians/"
#   page = agent.get(url)
#   if depth == 0
#     print "...Parsing Connecticut Children's Medical Center...\n"
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

# Greenwich Hospital
def parse_page_greenwich(url, agent, depth)
  hospital_name = "Greenwich Hospital"
  base = "http://www.greenhosp.org/physicians/"
  page = agent.get(url)
    if depth == 0
      print "...Parsing Greenwich Hospital...\n"
      items = page.search(".docResultsList td a")
      items[1..(items.length - 1)].each do |li|
        # parse_page_ccmc(link, agent, depth + 1)
      end
    else
      # items = page.search(".phsy-search-spec")
      # items[0..(items.length - 1)].each do |li|
      #   name = li.search("h2").text.split(",", 2).first
      #   print "......Parsing #{name}..."
      #   specialty = li.search("a").first.text
      #   hospital = Hospital.find_by_name(hospital_name)
      #   provider = Provider.find(name: name, hospital_id: hospital.id )
      #   provider ||= Provider.create(name: name.titleize, 
      #                                specialty: specialty.titleize)
      #   specialty = Specialty.find_by_name(name.titleize)
      #   specialty ||= Specialty.create(name: name.titleize, provider_id: provider.id)
      #   print "DONE\n"
      print "...DONE\n"
    end  
  end