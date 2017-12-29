require 'open-uri'
require 'nokogiri'

Fighter.destroy_all
Fight.destroy_all

$flyweights = Array.new([])
$bantamweights = Array.new([])
$featherweights = Array.new([])
$lightweights = Array.new([])
$welterweights = Array.new([])
$middleweights = Array.new([])
$lightheavyweights = Array.new([])
$heavyweights = Array.new([])

def createFights
	puts 'Flyweights:' + $flyweights.to_s
	puts 'Bantamweights:' + $bantamweights.to_s
	puts 'Featherweights:' + $featherweights.to_s
	puts 'Lightweights:' + $lightweights.to_s
	puts 'Welterweights:' + $welterweights.to_s
	puts 'Middleweights:' + $middleweights.to_s
	puts 'Light Heavyweights:' + $lightheavyweights.to_s
	puts 'Heavyweights:' + $heavyweights.to_s
end

def createFighter(division, rank, name, url, rank_number)
	puts division

	puts rank

	puts name

	#Fighter's photo url
	document_two = open(url)
	content_two = document_two.read
	parsed_content_two = Nokogiri::HTML(content_two)

	photo_url = parsed_content_two.css('div#content').css('.content-inner').css('div#fighter-details').css('.fighter-image')

	str1 ='<img src="//'
	str2 = '" alt'

	puts photo_url.to_s[/#{str1}(.*?)#{str2}/m, 1].to_s
  img_url = 'http://'+photo_url.to_s[/#{str1}(.*?)#{str2}/m, 1].to_s

  fighter_details = parsed_content_two.css('div#content').css('.content-inner').css('div#fighter-details').css('div#fighter-overlay')

	# Fighter's record

	str1 = '<span class="fighter-record">'
	str2 = '<span'

	record = fighter_details.css('.fighter-record').to_s
	puts 'Record: ' + record[/#{str1}(.*?)#{str2}/m, 1].to_s
  the_record = record[/#{str1}(.*?)#{str2}/m, 1].to_s

  f = Fighter.create(name: name, division: division, rank: rank, rank_number: rank_number, img_url: img_url, fight_record: the_record)
	if division == 'Flyweight'
		$flyweights.push(f)
	elsif division == 'Bantamweight'
		$bantamweights.push(f)
	elsif division == 'Featherweight'
		$featherweights.push(f)
	elsif division == 'Lightweight'
		$lightweights.push(f)
	elsif division == 'Welterweight'
		$welterweights.push(f)
	elsif division == 'Middleweight'
		$middleweights.push(f)
	elsif division == 'Light Heavyweight'
		$lightheavyweights.push(f)
	elsif division == 'Heavyweight'
		$heavyweights.push(f)
	end


end

def createFights
	puts 'Flyweights:' + $flyweights.to_s
	$i = 0
	while $i < 15  do
		if $i + 1 < 15
			Fight.create(division: 'Flyweight', upvotes: 0, fighter_one_id: $flyweights[$i].id, fighter_two_id: $flyweights[$i+1].id)
		end
		if $i + 2 < 15
			Fight.create(division: 'Flyweight', upvotes: 0, fighter_one_id: $flyweights[$i].id, fighter_two_id: $flyweights[$i+2].id)
		end
		if $i + 3 < 15
			Fight.create(division: 'Flyweight', upvotes: 0, fighter_one_id: $flyweights[$i].id, fighter_two_id: $flyweights[$i+3].id)
		end
		if $i + 4 < 15
			Fight.create(division: 'Flyweight', upvotes: 0, fighter_one_id: $flyweights[$i].id, fighter_two_id: $flyweights[$i+4].id)
		end
   	$i +=1
	end

	#puts 'Bantamweights:' + $bantamweights.to_s
	#puts 'Featherweights:' + $featherweights.to_s
	#puts 'Lightweights:' + $lightweights.to_s
	#puts 'Welterweights:' + $welterweights.to_s
	#puts 'Middleweights:' + $middleweights.to_s
	#puts 'Light Heavyweights:' + $lightheavyweights.to_s
	#puts 'Heavyweights:' + $heavyweights.to_s
end

puts "---------FIGHTERS---------"

document = open('http://www.ufc.com/rankings/')
content = document.read

parsed_content = Nokogiri::HTML(content)

# Get the divisions
divisions = parsed_content.css('div#fighter-rankings').css('div#ranking-lists').css('.ranking-list')

# Delete pound for pound division
divisions.shift

# Delete Women's featherweight division
divisions.pop

divisions.each{|division|
	# Have the division's name ready
	division_name = division.css('.weight-class-name').inner_text.strip

	# Create the champion of the division
	champion_name = division.css('span#champion-fighter-name').inner_text.strip

	champion_rank = 'Champion '+division_name

	str1 = '<a href="'
	str2 = '">'
	url = 'http://www.ufc.com'+division.css('span#champion-fighter-name').css('a').to_s[/#{str1}(.*?)#{str2}/m, 1]

	createFighter(division_name, champion_rank, champion_name, url, 0)

	# Create the challengers of the division

	division_rankings = division.css('.rankings-table').css('tr')
	division_rankings.each{|division_rank|
		rank = division_rank.css('.number-column').inner_text.strip
		fighter_rank = '# '+ rank + ' ' + division_name
		name = division_rank.css('.name-column').css('a').inner_text.strip
		#puts name

		str1 = '<a href="'
		str2 = '">'
		url = 'http://www.ufc.com'+division_rank.css('.name-column').css('a').to_s[/#{str1}(.*?)#{str2}/m, 1]

		createFighter(division_name, fighter_rank, name, url, rank)

	}

}
createFights()
