# Parse New Milford Hospital providers
namespace :framework do
  desc "Scrape data about New Milford Hospital providers"
  task nmh: :environment do
    print "...Parsing New Milford and Danburry Hospital providers\n"
    agent = Mechanize.new
    female = 34
    (1..female).each do |page|
      base_nmh = "http://www.newmilfordhospital.org/Find-a-Doc/Results?page=#{page.to_s}&gender=female"
      process_page_nmh(base_nmh, agent)
    end

    male = 50
    (1..male).each do |page|
      base_nmh = "http://www.newmilfordhospital.org/Find-a-Doc/Results?page=#{page.to_s}&gender=male"
      process_page_nmh(base_nmh, agent)
    end
    print "...DONE\n"
  end
end

def process_page_nmh(url, agent)
  hospital_name1 = "New Milford Hospital".titleize
  hospital_name2 = "Danbury Hospital".titleize
  page = agent.get(url)
  rowsOdd = page.search(".doc-module")
  rowsOdd[0..(rowsOdd.length - 1)].each do |tr|
    name = tr.search(".doc-content h3 a").text.titleize
    spec = tr.search(".doc-content .doc-heading").first.text.squeeze(" ").strip.titleize
    print "......Parsing #{name}"
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
end