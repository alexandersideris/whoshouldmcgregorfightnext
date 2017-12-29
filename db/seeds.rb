require 'open-uri'
require 'nokogiri'


$flyweights = Array.new([])
$bantamweights = Array.new([])
$featherweights = Array.new([])
$lightweights = Array.new([])
$welterweights = Array.new([])
$middleweights = Array.new([])
$lightheavyweights = Array.new([])
$heavyweights = Array.new([])

$womenstrawweights = Array.new([])
$womenflyweights = Array.new([])
$womenbantamweights = Array.new([])
$womenfeatherweights = Array.new([])

def createFights
	puts 'Flyweights:' + $flyweights.to_s
	puts 'Bantamweights:' + $bantamweights.to_s
	puts 'Featherweights:' + $featherweights.to_s
	puts 'Lightweights:' + $lightweights.to_s
	puts 'Welterweights:' + $welterweights.to_s
	puts 'Middleweights:' + $middleweights.to_s
	puts 'Light Heavyweights:' + $lightheavyweights.to_s
	puts 'Heavyweights:' + $heavyweights.to_s

	puts 'Women Strawweights:' + $womenstrawweights.to_s
	puts 'Women Flyweights:' + $womenflyweights.to_s
	puts 'Women Bantamweights:' + $womenbantamweights.to_s
	puts 'Women Featherweights:' + $womenfeatherweights.to_s
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
  	img_url = 'https://'+photo_url.to_s[/#{str1}(.*?)#{str2}/m, 1].to_s

  	fighter_details = parsed_content_two.css('div#content').css('.content-inner').css('div#fighter-details').css('div#fighter-overlay')

	# Fighter's record

	str1 = '<span class="fighter-record">'
	str2 = '<span'

	record = fighter_details.css('.fighter-record').to_s
	puts 'Record: ' + record[/#{str1}(.*?)#{str2}/m, 1].to_s
  the_record = record[/#{str1}(.*?)#{str2}/m, 1].to_s

	# Check if the fighter already exists in the database. We will pretend that names are unique, which they are atm
	f = Fighter.where(name: name).take
	if f != nil
		f.division = division
		f.rank = rank
		f.rank_number = rank_number
		f.img_url = img_url
		f.fight_record = the_record
		f.is_updated = 'true'
		f.save
	else
		f = Fighter.create(name: name, division: division, rank: rank, rank_number: rank_number, img_url: img_url, fight_record: the_record, is_updated: 'true')
	end


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
	elsif division == "Women's Strawweight"
		$womenstrawweights.push(f)
	elsif division == "Women's Flyweight"
		$womenflyweights.push(f)
	elsif division == "Women's Bantamweight"
		$womenbantamweights.push(f)
	elsif division == "Women's Featherweight"
		$womenfeatherweights.push(f)
	end


end

def createTheFights(division_text, division)
	$i = 0
	while $i < 16  do
		j=1
		while j < 9 do
			if $i + j < 16
				f = Fight.where("fighter_one_id = "+division[$i].id.to_s + " and fighter_two_id = " + division[$i+j].id.to_s + "or fighter_one_id = "+division[$i+j].id.to_s + "and fighter_two_id = " + division[$i].id.to_s).first
				#puts 'f: ' + f.to_s
				if f != nil
					f.fighter_one_id = division[$i].id
					f.fighter_two_id = division[$i+j].id
					f.division = division_text
					f.save
				else
					Fight.create(division: division_text, upvotes: 0, fighter_one_id: division[$i].id, fighter_two_id: division[$i+j].id)					
				end
				
			end
			j += 1
		end
   		$i +=1
	end

end

def createTheSuperFight(champion_one, champion_two)
	f = Fight.where("fighter_one_id = "+champion_one.id.to_s + " and fighter_two_id = " + champion_two.id.to_s + "or fighter_one_id = "+champion_two.id.to_s + "and fighter_two_id = " + champion_one.id.to_s).first

	if f != nil
		f.fighter_one_id = champion_one.id
		f.fighter_two_id = champion_two.id
		f.division = 'Superfight'
		f.save
	else
		Fight.create(division: "Superfight", upvotes: 0, fighter_one_id: champion_one.id, fighter_two_id: champion_two.id)					
	end


end

def createFights
	puts 'Flyweights:' + $flyweights.to_s
	createTheFights('Flyweight', $flyweights)
	createTheSuperFight($flyweights[0], $bantamweights[0])

	puts 'Bantamweights:' + $bantamweights.to_s
	createTheFights('Bantamweight', $bantamweights)
	createTheSuperFight($bantamweights[0], $featherweights[0])


	puts 'Featherweights:' + $featherweights.to_s
	createTheFights('Featherweight', $featherweights)
	createTheSuperFight($featherweights[0], $lightweights[0])


	puts 'Lightweights:' + $lightweights.to_s
	createTheFights('Lightweight', $lightweights)
	createTheSuperFight($lightweights[0], $welterweights[0])

	puts 'Welterweights:' + $welterweights.to_s
	createTheFights('Welterweight', $welterweights)
	createTheSuperFight($welterweights[0], $middleweights[0])

	puts 'Middleweights:' + $middleweights.to_s
	createTheFights('Middleweight', $middleweights)
	createTheSuperFight($middleweights[0], $lightheavyweights[0])

	puts 'Light Heavyweights:' + $lightheavyweights.to_s
	createTheFights('Light Heavyweight', $lightheavyweights)
	createTheSuperFight($lightheavyweights[0], $heavyweights[0])

	puts 'Heavyweights:' + $heavyweights.to_s
	createTheFights('Heavyweight', $heavyweights)

	# WOMEN

	puts 'Women Strawweights:' + $womenstrawweights.to_s
	createTheFights("Women's Strawweight", $womenstrawweights)
	createTheSuperFight($womenstrawweights[0], $womenflyweights[0])


	puts 'Women Flyweights:' + $womenflyweights.to_s
	createTheFights("Women's Flyweight", $womenflyweights)
	createTheSuperFight($womenflyweights[0], $womenbantamweights[0])


	puts "Women's Bantamweights:" + $womenbantamweights.to_s
	createTheFights("Women's Bantamweight", $womenbantamweights)

	puts "Women's Featherweights:" + $womenfeatherweights.to_s
		


end


fighters = Fighter.all
fighters.each{|fighter|
	fighter.is_updated = 'false'
	fighter.save
}

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
		fighter_rank = '#'+ rank + ' ' + division_name
		name = division_rank.css('.name-column').css('a').inner_text.strip
		#puts name

		str1 = '<a href="'
		str2 = '">'
		url = 'http://www.ufc.com'+division_rank.css('.name-column').css('a').to_s[/#{str1}(.*?)#{str2}/m, 1]

		createFighter(division_name, fighter_rank, name, url, rank)

	}

}
createFights()

# Now check the fighters where is_updated=false. That means they are no longer ranked in the top 15. Delete their fights and delete them.

unranked_fighters = Fighter.where(is_updated: 'false')
unranked_fighters.each{|f|
	# Delete all their fights
	fights = Fight.where("fighter_one_id = '"+f.id+"' OR fighter_two_id = '"+f.id+"'")
	fight.each{|fi|
		Fight.destroy(fi.id)
	}
	Fighter.destroy(f.id)
}
