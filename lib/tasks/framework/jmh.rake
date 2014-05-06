# Parse Johnson Memorial Hospital providers
namespace :framework do
  desc "Scrape data about Johnson Memorial Hospital providers"
  task jmh: :environment do
    print "...Parsing Johnson Memorial Hospital providers\n"
    agent = Mechanize.new
    base_jmh = "http://www.jmmc.com/findadoctor/search/?name=&city=&zip=&search=#top"
    process_page_jmh(base_jmh, agent, 0, "a")
    print "...DONE\n"
  end
end

def process_page_jmh(url, agent, depth, specialty)
  hospital_name = "Johnson Memorial Hospital".titleize
  page = agent.get(url)
  if depth == 0
    rows = page.search("ul li a")
    rows[147..(rows.length - 1)].each do |tr|
      spec = tr.text
      link = tr.first.last
      process_page_jmh(link, agent, depth + 1, spec)
    end
  else
    i = 0
    rows = page.search("b .maintext")
    rows[0..(rows.length - 1)].each do |tr|
      if i % 2 == 1
        name = tr.text.titleize
        spec = specialty.titleize
        print "......Parsing #{name} #{spec}"
        hospital = Hospital.find_by_name(hospital_name)
        hid = hospital.id.to_s
        provider  = Provider.create(name: name, hospital_id: hid)
        pid = provider.id.to_s
        spec1 = Specialty.create(name: spec, provider_id: pid)
        print "...DONE\n"
      end
      i = i + 1
    end
  end
end