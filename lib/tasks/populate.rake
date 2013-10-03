namespace :db do
  desc "Fill friend table with sample data"
  task populate: :environment do
    10.times do |n|
      name = Faker::Name.name
      surname = Faker::Name.name
      email = "email-#{n+1}@example.com"
      password = "password"
      puts "[DEBUG] creating user #{n+1} of 10 name= "<<name
      Friend.create!( name: name,
                      surname: surname,
                    email: email,
                    password: password,
                    password_confirmation: password)
    end
    #    User.all.each do |user|
    #   puts "[DEBUG] uploading images for user #{user.id} of #{User.last.id}"
    #   10.times do |n|
    #     image = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample)
    #     description = %w(cool awesome crazy wow adorbs incredible).sample
    #     user.pins.create!(image: image, description: description)
    #   end
    # end
  end
end