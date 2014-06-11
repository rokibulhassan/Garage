desc 'add other langauage data for pre_written_comments'
task :add_other_languages => :environment do
array = ["ar", "bg", "cs", "da", "de", "es", "fa", "fi", "grc", "hu", "id", "it", "ja", "ko", "nl", "no", "pl", "pt", "ro", "ru", "sk", "sv", "tr", "vi", "zh"]
	PrewrittenVersionComment.all.each do |pvc|
		pvc.update_attributes("body_#{array[0]}"=>pvc.body_en, "body_#{array[1]}"=>pvc.body_en, "body_#{array[2]}"=>pvc.body_en, "body_#{array[3]}"=>pvc.body_en, "body_#{array[4]}"=>pvc.body_en, "body_#{array[5]}"=>pvc.body_en, "body_#{array[6]}"=>pvc.body_en, "body_#{array[7]}"=>pvc.body_en, "body_#{array[8]}"=>pvc.body_en, "body_#{array[9]}"=>pvc.body_en, "body_#{array[10]}"=>pvc.body_en, "body_#{array[11]}"=>pvc.body_en, "body_#{array[12]}"=>pvc.body_en, "body_#{array[13]}"=>pvc.body_en, "body_#{array[14]}"=>pvc.body_en, "body_#{array[15]}"=>pvc.body_en, "body_#{array[16]}"=>pvc.body_en, "body_#{array[17]}"=>pvc.body_en, "body_#{array[18]}"=>pvc.body_en, "body_#{array[19]}"=>pvc.body_en, "body_#{array[20]}"=>pvc.body_en, "body_#{array[21]}"=>pvc.body_en, "body_#{array[22]}"=>pvc.body_en, "body_#{array[23]}"=>pvc.body_en, "body_#{array[24]}"=>pvc.body_en)
		puts "comments added"
	end
end
