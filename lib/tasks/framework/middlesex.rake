# Parse Middlesex Hospital providers
namespace :framework do
  desc "Scrape data about Middlesex Hospital providers"
  task middlesex: :environment do
    print "...Parsing Middlesex Hospital providers\n"
    agent = Mechanize.new
    num_pages = 19
    (1..num_pages).each do |page|
      base_middlesex = "http://middlesexhospital.org/find-a-physician/page/#{page.to_s}"
      process_page_middlesex(base_middlesex, agent)
    end
    print "...DONE\n"
  end
end

def process_page_middlesex(url, agent)
  page = agent.get(url)
  rowsOdd = page.search(".odd")
  rowsOdd[0..(rowsOdd.length - 1)].each do |tr|
    abstract_away(tr)
  end

  rowsEven = page.search(".even")
  rowsEven[0..(rowsEven.length - 1)].each do |tr|
    abstract_away(tr)
  end
end

def abstract_away(tr)
  hospital_name = "Middlesex Hospital".titleize
  name = tr.search("td a").text.titleize
  spec = tr.search("td")[2].text.split(",", 2).first
  print "......Parsing #{name} #{spec}"
  hospital = Hospital.find_by_name(hospital_name)
  hid = hospital.id.to_s
  provider  = Provider.create(name: name, hospital_id: hid)
  pid = provider.id.to_s
  specialty = Specialty.create(name: spec, provider_id: pid)
  print "...DONE\n"
end