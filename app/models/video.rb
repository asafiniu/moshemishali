class Video < ActiveRecord::Base
	attr_accessible :description, :title, :url, :typename, :image_url, :synopsis

	def is_valid
		(nil != (self.typename =~ /filmography/)) or 
		(nil != (self.typename =~ /music_video|film|commercial/) and nil != (self.image_url =~ /jpg|png|gif/))
	end

	def self.invalids
		Video.all.select{|v| !v.is_valid}
	end

	def self.by_type(typename)
		Video.find_all_by_typename(typename).sort_by{|v| v.created_at}.reverse
	end

	def self.create_all
		Video.delete_all
		Video.create_commercials
		Video.create_musicvideos
		Video.create_films
		Video.create_filmography
	end

	private

	@@ytb = "http://www.youtube-nocookie.com/embed/"
	
	def self.create_commercials
		Video.create({
			:title =>  "Maccabi Beer - Sound Check",
			:image_url =>  "Posters/commercial/maccabi_soundcheck.jpg",
			:url =>  @@ytb + "MXsNeMFwrA4",
			:description =>  "with Asaf Avidan;Director - Adam bizanski;2nd Unit cinematography - Eli Aharonson",
			:typename =>  "commercial"	
			})	

		Video.create({
			:title => "Maccabi Home Tour - The SMS",
			:image_url => "Posters/commercial/maccabi_sms.jpg",
			:url => @@ytb + "vAzjqpfmpBc",
			:description => "with Shlomi Shaban;Director - Adam bizanski",
			:typename => "commercial"
			})		

		Video.create({
			:title => "Maccabi Home Tour - Big Time",
			:image_url => "Posters/commercial/maccabi_bigtime.jpg",
			:url => @@ytb + "i_s6ErUTvCg",
			:description => "with Shlomi Shaban;Director - Adam bizanski",
			:typename => "commercial"
			})
		
		Video.create({
			:title => "Maccabi Home Tour - The Monolog",
			:image_url => "Posters/commercial/maccabi_monolog.jpg",
			:url => @@ytb + "CiFbEHC0TVc",
			:description => "with Shlomi Shaban;Director - Adam bizanski",
			:typename => "commercial"
			})
		

		Video.create({
			:title => "El Namrod",
			:image_url => "Posters/commercial/elnamroud.jpg",
			:url => @@ytb + "DGN_XvqvlTs",
			:description => "Directors - Tal Greenberg &amp; Yasmin Shryer;Additional Cinematography - Roee Mandelevitch",
			:typename => "commercial"
			})
		

		Video.create({
			:title => "MyCheck",
			:image_url => "Posters/commercial/mycheck.jpg",
			:url => @@ytb + "hcgOdQQonN4",
			:description => "Director - Vania Heymann",
			:typename => "commercial"
			})
		

		Video.create({
			:title => "American Express - The Young Professionals Project",
			:image_url => "Posters/commercial/typ.jpg",
			:url => @@ytb + "uHZo6c0Fvgg",
			:description => "Director - Vania Heymann",
			:typename => "commercial"
			})
		

		Video.create({
			:title => "Pepsi Max",
			:image_url => "Posters/commercial/pepsimax.jpg",
			:url => @@ytb + "gfpW-hKx2Yg",
			:description => "Director - Vania Heymann",
			:typename => "commercial"
			})
		

		Video.create({
			:title => "Soundcheck - Aviv Geffen",
			:image_url => "Posters/commercial/maccabi_avivgeffen.jpg",
			:url => @@ytb + "djr3cIVRGgw",
			:description => "Director - Adam Bizanski",
			:typename => "commercial"
			})
		

		logger.info("Created " + i.to_s + " commercials")
	end


	def self.create_musicvideos
		
		Video.create({
			:title => "Amsterdam",
			:image_url => "Posters/musicvideos/amsterdam.jpg",
			:url => @@ytb + "URQDqaOIq6s",
			:description => "Hageveret Harishona;Director - Adi Yager",
			:typename => "music_video"
			})
		

		Video.create({
			:title => "Too Afraid to Love You",
			:image_url => "Posters/musicvideos/tooafraid.jpg",
			:description => "Black Keys;Director - Adam bizanski",
			:url => @@ytb + "Ft_-5kuYY-E",
			:typename => "music_video"
			})
		

		Video.create({
			:title => "A Secret Day",
			:image_url => "Posters/musicvideos/secretday.jpg",
			:description => "Omer Leshem;Director - Asaph Polonsky",
			:url => @@ytb + "eGbItkCl1g4",
			:typename => "music_video"
			})
		

		Video.create({
			:title => "Halomot Ra&quot;im (Bad Dreams)",
			:image_url => "Posters/musicvideos/baddreams.jpg",
			:description => "Cohen @ Mushon;Director - Gal Muggia",
			:url => @@ytb + "qqZ1HwLMoro",
			:typename => "music_video"
			})
		

		logger.info("Created " + i.to_s + " music videos")
	end

	def self.create_films
		
		v = Video.new()
		v[:title] = "Paul" 
		v[:image_url] = "Posters/films/paul.jpg"
		v[:description] = "Israel 2011, 26min;Director : Adam Bizanski"
		v[:url] = @@ytb + "1xEReh8ygnU"
		v[:synopsis] = "Still in the aftermath of a tough break up, Paul&quot;s life is slowly deteriorating."
		v[:synopsis] += " A mindless burglary of his rented apartment forces him to to push through the underworld"
		v[:synopsis] += " of Tel Avivto investigate.;;"
		v[:synopsis] += "<b>Haifa International Film Festival</b> - 2011" 
		v[:typename] = "film"
		v.save
		

		v = Video.new()
		v[:title] = "Martha Must Fly" 
		v[:image_url] = "Posters/films/martha.jpg" 
		v[:description] = "Israel 2011, 26min;Director : Ma&quot;ayan Rypp;"
		v[:url] = @@ytb + "Kjc4ooThuO8"
		v[:synopsis] = "Martha is a foreign worker employed as a caretaker of sick old woman who refuses to die."
		v[:synopsis] += " Martha&quot;s only moments of freedom come when she delves into her imaginary world."
		v[:synopsis] += " Feeling trapped and lonely, Martha tries to free herself but the authorities make it"
		v[:synopsis] += " clear to her that until the old woman dies she must stay. She decides to fight for her"
		v[:synopsis] += " freedom but reality pushes her into her fantasy world, one last time.;;<b>"
		v[:synopsis] += "Cannes - Cinefoundation</b> - official selection 2011;<b>Jerusalem International Film"
		v[:synopsis] += " Festival</b> - Israeli Short Film Competition 2011;"
		v[:synopsis] += "<b>Cyprus International Short Film Festival</b> - 2011 - Received Special Mention for"
		v[:synopsis] += " Best Actress and Official Students Choice.;"
		v[:synopsis] += "<b>Rehovot Women&quot;s Film Festival</b> - nominated for Best Drama and winner of"
		v[:synopsis] += " most Promising Director;<b>Lodz 18th International Film and TV Schools"
		v[:synopsis] += " Festival &quot;MEDIASCHOOL 2011&quot;</b>;<b>International Student and Video Festival"
		v[:synopsis] += " of Beijing Film Academy</b> - 2011;"
		v[:synopsis] += "<b>New Taipei City Film Festival</b> - Panorama Program, 2011"
		v[:typename] = "film"
		v.save
		

		v = Video.new()
		v[:title] = "In Bed at 10pm" 
		v[:image_url] = "Posters/films/bed.jpg" 
		v[:description] = "Israel 2010, 15min;Director : Asaph Polonsky"
		v[:url] = @@ytb + "AwgqgWsyax8"
		v[:synopsis] = "Rachel is a librarian; she knows all about how language works."
		v[:synopsis] += " When her lover&quot;s mobile phone rings twice during a sleep over in her flat,"
		v[:synopsis] += " he informs her of its meaning."
		v[:synopsis] += " His wife needs him, it is urgent and overrides their arrangement that he keep a mistress."
		v[:synopsis] += " At 70, how will Rachel find a love deeper than Motti&quot;s and move from mistress to top"
		v[:synopsis] += " billing? She must act."
		v[:synopsis] += " With the help of a younger colleague, she \"tweaks\" her internet profile and begins"
		v[:synopsis] += " the dispiriting process of dating. Disappointment is everywhere, just as it is for"
		v[:synopsis] += " younger wannabe lovers."
		v[:synopsis] += " It&quot;s not so much a moral dilemma as a literary one.;;<b>CFC - Toronto International"
		v[:synopsis] += " Film Festival</b> - 2011;<b>MIFF - Milano International Film Festival</b> - 2011;"
		v[:synopsis] += "<b>L.A. Shorts Fest</b> - 2011;<b>Jerusalm International Film Festival</b> - 2010"
		v[:typename] = "film"
		v.save
		

		Video.create({
			:title => "Private Rooms",
			:image_url => "Posters/films/privaterooms.jpg",
			:typename => "film"
			})
		

		v = Video.new()
		v[:title] = "Zipper"
		v[:image_url] = "Posters/films/zipper.jpg"
		v[:description] = "Israel 2008, 34min;Director : Asaph Polonsky"
		v[:url] = @@ytb + "g84VOBqisaQ"
		v[:synopsis] = "Surrounded by fake landscapes formed by jigsaw puzzles and being dependent upon"
		v[:synopsis] += " high dosage of tranquilizers, the fragile reality that Yaki has built for himself"
		v[:synopsis] += " during his compulsory solitude will shatter in face of the complex relationship"
		v[:synopsis] += " that would ensue with the stranger invading his house - and life.;;"
		v[:synopsis] += "<b>Mexico Film Festival 2010</b> - Silver Palm Award Winner;<b>Jerusalem International "
		v[:synopsis] += " Film Festival</b> - 2009;<b>Akbank Short Film Festival</b> - 2008;<b>Miami Short Film "
		v[:synopsis] += " Festival</b> - 2008;<b>Boston Jewish Film Festival</b> - 2009;<b>Real to Reel Film Festival</b>"
		v[:synopsis] += " - 2009;<b>Glimmer: the 7th Hull International Film Festival</b> - 2009"
		v[:typename] = "film"
		v.save
		

		Video.create({
			:title => "The Thirsty Man",
			:image_url => "Posters/films/thirsty.jpg",
			:description => "Israel 2012, 6min;Director: Eitan Aner",
			:url => @@ytb + "FIBSTK4ndHM",
			:typename => "film"
			})
		

		# v = Video.new()
		# v[:title] = "Batman at the Checkpoint"
		# v[:image_url] = "Posters/films/batman.jpg"
		# v[:description] = "Israel 2011, 9min;Director: Rafael Balulu"
		# v[:url] = ""
		# v[:synopsis] = "An Israeli car and a Palestinian car are stuck in traffic in front of a barricade at the entrance of Jerusalem,"
		# v[:synopsis] += " coming from the Dead Sea. Yuval and Mahmoud, both two six-year-old boys, find that it&quot;s much more fun to"
		# v[:synopsis] += " pass the time playing with one another. But when Mahmoud&quot;s father tries to cut into the other&quot;s lane,"
		# v[:synopsis] += " Yuval&quot;s father bumps into his car in an attempt to prevent him, and things start to get complicated."
		# v[:synopsis] += " What began as a game becomes an outright battle for a plastic Batman doll.;;<b>Winner of Berlin Today award</b> - 2012"
		# v.save
		# 

		logger.info("Created " + i.to_s + " films")
	end

	def self.create_filmography
		
		Video.create({
			:title => "Letters From The war", 
			:description => "50 min, short drama, work in progress, 2013.",
			:typename => "filmography_film"
			})
		

		Video.create({
			:title => "Zirei Poranut", 
			:description => "60 min, short drama, 2013.",
			:typename => "filmography_film"
			})
		

		Video.create({
			:title => "Shadows",
			:description => "17 min, Short film, work in progress, 2012.",
			:typename => "filmography_film"
			})
		

		Video.create({
			:title => "Mesuvag Harig", 
			:description => "80 min, Horror feature film, HD, work in progress, 2012.",
			:typename => "filmography_film"
			})
		

		Video.create({
			:title => "Mot Neshika",
			:description => "Short film, HD, work in progress, 2012.",
			:typename => "filmography_film"
			})
		

		Video.create({
			:title => "Windows 2000", 
			:description => "indi, feature film, HD, work in progress, 2011&#150;2012.",
			:typename => "filmography_film"
			})
		

		Video.create({
			:title => "Batman at a Checkpoint", 
			:description => "9 min, Short film, HD, winner of Berlin Today Award at Berlin Film Festival, 2012.",
			:typename => "filmography_film"
			})
		

		Video.create({
			:title => "Paul", 
			:description => "26 min, short film, Edinburgh Film Festival, winner of Silver Hugo at Chicago film festival, 2011 &#150; 2012.",
			:typename => "filmography_film"
			})
		

		Video.create({
			:title => "Marta Must Fly", 
			:description => "26 min, short film. HD, Cannes film festival, 2011, cinefoundation official selection, Jerusalem film festival, 2011.",
			:typename => "filmography_film"
			})
		

		Video.create({
			:title => "In bed at 10 p.m.", 
			:description => "15 min, short film, HD, Toronto short film festival, 2011, Milan film festival, 2011, L.A. short film festival 2011, Jerusalem film festival, 2010.",
			:typename => "filmography_film"
			})
		

		Video.create({
			:title => "Private Rooms", 
			:description => "27 min, short film, HD, Jerusalem film festival, 2010.",
			:typename => "filmography_film"
			})
		

		Video.create({
			:title => "Zipper", 
			:description => "34 min, short film, DIGIBETA, Miami film festival, 2009, Jerusalem film festival, 2009.",
			:typename => "filmography_film"
			})
		

		# Filmography - Music Videos

		Video.create({
			:title => "American Express", 
			:description => "TYP music video, 2012.",
			:typename => "filmography_film"
			})
		

		Video.create({ 
			:title => "MyCheck", 
			:description => "web commercial, 2012.", 
			:typename => "filmography_musicvideo" 
			}) 
		
		
		Video.create({ 
			:title => "Time", 
			:description => "Izabo music video (Eurovision song), 2012.", 
			:typename => "filmography_musicvideo" 
			}) 
		
		
		Video.create({ 
			:title => "I like it", 
			:description => "Izabo music video.", 
			:typename => "filmography_musicvideo" 
			}) 
		

		Video.create({ 
			:title => "Pepsi Max", 
			:description => "Beatbox web commercial, 2012.", 
			:typename => "filmography_musicvideo" 
			}) 
		

		Video.create({ 
			:title => "Maccabi Beer Home Tour", 
			:description => "5 web commercials, 2010&#150;2012.", 
			:typename => "filmography_musicvideo" 
			}) 
		
		
		Video.create({ 
			:title => "Dancing with Stars", 
			:description => "TV promo, 2010", 
			:typename => "filmography_musicvideo" 
			}) 
		
		
		Video.create({ 
			:title => "Narroweyes", 
			:description => "video dance, winner of Tel Aviv int. Vdance festival, 2007.", 
			:typename => "filmography_musicvideo" 
			}) 
		

		# Filmography - Television

		Video.create({ 
			:title => "Ptzuim Barosh", 
			:description => "2nd unit cinematography, 2013", 
			:typename => "filmography_television" 
			}) 
		
		
		Video.create({ 
			:title => "Bekizur", 
			:description => "TV/Web series, DOP, 2012.", 
			:typename => "filmography_television" 
			}) 
		
		
		Video.create({ 
			:title => "Zamar Mizrahi", 
			:description => "TV comedy, 2nd unit cinematography.", 
			:typename => "filmography_television" 
			}) 
		
		
		Video.create({ 
			:title => "Pilpelim Tsehubim", 
			:description => "1st & 2nd seasons, TV series, additional cinematography, 2010.", 
			:typename => "filmography_television" 
			}) 
		
		
		Video.create({ 
			:title => "Holly Community, Katmandu", 
			:description => "TV series, supplements d.o.p, 2011.", 
			:typename => "filmography_television" 
			}) 
		

		Video.create({ 
			:title => "Galis", 
			:description => "TV series, 2nd unit cinematography, 2011&#150;2012.", 
			:typename => "filmography_television" 
			}) 


		Video.create({ 
			:title => "Kovach & Duvdevani", 
			:description => "TV series, 2 unit cinematography, 2011.", 
			:typename => "filmography_television" 
			}) 


		Video.create({ 
			:title => "Mivza Kipod", 
			:description => "TV series, 2 unit cinematography, 2011", 
			:typename => "filmography_television" 
			}) 


		Video.create({ 
			:title => "Survivor", 
			:description => "season 2, 4 & 5, Technical director, 2008&#150;2010", 
			:typename => "filmography_television" 
			}) 


		Video.create({ 
			:title => "Top Gear", 
			:description => "TV series, Israeli version, 2nd season, 2008", 
			:typename => "filmography_television" 
			}) 


		logger.info("Created " + i.to_s + " filmography records")
	end
end