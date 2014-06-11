desc 'migrate user avatars from paperclip to carrierwave'
task :paperclip_to_carrierwave => :environment do
  FileUtils.mkdir_p Rails.root.join('public', 'system')

  User.find_in_batches(:batch_size => 50) do |users|
    users.each do |user|
      if user.avatar_file_name.blank?
        next
      else
        user.avatar = File.open(Rails.root.join('public', 'system', 'users', 'avatars', '000', '000', ("%03d" % user.id), 'original', user.avatar_file_name))
        user.save!
      end
    end
  end
end
