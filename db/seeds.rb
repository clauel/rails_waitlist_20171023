Request.create!(name:  "Example Request",
             email: "example@request.org",
             phone: '0123456789',
             bio: 'blablabla',
             activated: true,
             activated_at: Time.zone.now,
             confirmed: true,
             confirmed_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@request.org"
  bio = Faker::Lorem.sentence(5)
  activated = rand(2) > 0
  random_time = rand(0..31536000)
  if activated == true
    time = Time.zone.now-random_time
  else
    time = nil
  end
  Request.create!(name:  name,
              email: email,
              phone: '0123456789',
              bio: bio,
              activated: activated,
              activated_at: time,
              confirmed: activated,
              confirmed_at: time)
end
