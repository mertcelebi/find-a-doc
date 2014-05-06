# Parse Windham Hospital providers
namespace :framework do
  desc "Scrape data about Windham Hospital providers"
  task windham: :environment do
    print "...Parsing Windham Hospital providers\n"
    agent = Mechanize.new
    base_windham = "http://www.windhamhospital.org/find-a-doctor/physician-directory"
    process_page_windham(base_windham, agent, 0)
    print "...DONE\n"
  end
end

def process_page_windham(url, agent, depth)
  hospital_name = "Windham Hospital".titleize
  base = "http://www.windhamhospital.org"
  page = agent.get(url)
  if depth == 0
    rows = page.search(".one-column-layout .clearfix li")
    rows[3..(rows.length - 7)].each do |li|
      link = base + li.search("a").first["href"]
      process_page_windham(link, agent, depth + 1)
    end
  elsif depth == 1
    rows = page.search(".listing ul li")
    rows[0..(rows.length - 1)].each do |li|
      link = base + li.search("a").first["href"]
      process_page_windham(link, agent, depth + 1)
    end
  else
    rows = page.search(".left .right")
    rows[0..0].each do |li|
      name = li.search("h2").text.squeeze(" ").strip.titleize
      spec = li.search("p").text.squeeze(" ").strip.titleize
      print "......Parsing #{name}"
      hospital = Hospital.find_by_name(hospital_name)
      hid = hospital.id.to_s
      provider  = Provider.create(name: name, hospital_id: hid)
      pid = provider.id.to_s
      specialty = Specialty.create(name: spec, provider_id: pid)
      print "...DONE\n"
    end
  end
end