# Parse YNHH providers
namespace :framework do
  desc "Scrape data about YNHH providers"
  task ynhh: :environment do
    print "...Parsing YNHH providers\n"
    agent = Mechanize.new
    num_pages = 284
    (1..num_pages).each do |page|
      base_ynhh = "http://www.ynhh.org/ui/usercontrols/physfind/ajaxgetrows.aspx?simplestring=count=0&page=#{page.to_s}&count=0"
      process_page_ynhh(base_ynhh, agent)
    end
    print "...DONE\n"
  end
end

def process_page_ynhh(url, agent)
  hospital_name1 = "Yale-New Haven Hospital".titleize
  hospital_name2 = "Hospital of Saint Raphael".titleize
  page = agent.get(url)
  rows = page.search("tr")
  rows[1..(rows.length - 1)].each do |tr|
    link = tr.search("a").first
    name = link.text.titleize
    spec = tr.search("strong").last.text.titleize
    print "......Parsing #{name} #{spec}"
    hospital1 = Hospital.find_by_name(hospital_name1)
    hid1 = hospital1.id.to_s
    provider  = Provider.create(name: name, hospital_id: hid1)
    hospital2 = Hospital.find_by_name(hospital_name2)
    hid2 = hospital2.id.to_s
    provider  = Provider.create(name: name, hospital_id: hid2)
    pid = provider.id.to_s
    specialty = Specialty.create(name: spec, provider_id: pid)
    print "...DONE\n"
  end
end