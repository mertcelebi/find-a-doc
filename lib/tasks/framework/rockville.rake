# Parse Rockville General Hospital providers
namespace :framework do
  desc "Scrape data about Rockville General Hospital providers"
  task rockville: :environment do
    print "...Parsing Rockville General Hospital and Manchester Memorial Hospital providers\n"
    agent = Mechanize.new
    base_nmh = "http://www.echn.org/Find-a-Doctor.aspx?g=M"
    process_page_nmh(base_nmh, agent)
    base_nmh = "http://www.echn.org/Find-a-Doctor.aspx?g=F"
    process_page_nmh(base_nmh, agent)
    print "...DONE\n"
  end
end

def process_page_nmh(url, agent)
  hospital_name1 = "Rockville General Hospital".titleize
  hospital_name2 = "Manchester Memorial Hospital".titleize
  page = agent.get(url)
  rowsOdd = page.search(".dataTable tr")
  rowsOdd[0..(rowsOdd.length - 1)].each do |tr|
    name = tr.search("td a").text
    if name != ""
      print "......Parsing #{name}"
      speci = tr.search("td")
      i = 0
      speci[0..(speci.length - 1)].each do |temp|
        if i == 1
          spec = temp.text.squeeze(" ").strip.titleize
          hospital1 = Hospital.find_by_name(hospital_name1)
          hid1 = hospital1.id.to_s
          hospital2 = Hospital.find_by_name(hospital_name2)
          hid2 = hospital2.id.to_s
          provider  = Provider.create(name: name, hospital_id: hid1)
          pid = provider.id.to_s
          specialty = Specialty.create(name: spec, provider_id: pid)
          provider  = Provider.create(name: name, hospital_id: hid2)
          pid = provider.id.to_s
          specialty = Specialty.create(name: spec, provider_id: pid)
          print "...DONE\n"
        end
        i = i + 1
      end
    end
  end
end