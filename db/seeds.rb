# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ContractorAvailability.destroy_all
Quote.destroy_all
Job.destroy_all
Property.destroy_all
User.destroy_all

tenant_1 = User.create! ({
  first_name: "Tim",
  last_name:"Woods",
  email: "timmy@gmail.com",
  password: 123456,
  remote_avatar_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558707960/beyi17egfookljd2i2gp.png",
  user_type: "tenant"
})

landlord_1 = User.create! ({
  first_name: "Bob",
  last_name: "Jones",
  email: "bobby@gmail.com",
  password: 123456,
  remote_avatar_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558707946/joerhdoalcduig8nenwp.png",
  user_type: "landlord"
})

contractor_1 = User.create! ({
  first_name: "Ellie",
  last_name: "Electric",
  email: "ellie@gmail.com",
  password: 123456,
  remote_avatar_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558707923/mwfv7xkl9uquzqadgjmy.png",
  user_type: "contractor",
  contractor_type: "electrician"
})

contractor_2 = User.create! ({
  first_name: "Sparky",
  last_name: "Anderson",
  email: "sparky@gmail.com",
  password: 123456,
  remote_avatar_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558707979/u8hld1cp17rshv2pkay6.png",
  user_type: "contractor",
  contractor_type: "electrician"
})

contractor_3 = User.create! ({
  first_name: "Miguel",
  last_name: "San Pedro",
  email: "miguel@gmail.com",
  password: 123456,
  remote_avatar_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558707971/ugszwtmxvsiyrc5xud2c.png",
  user_type: "contractor",
  contractor_type: "electrician"
})

property_1 = Property.create! ({
  landlord: landlord_1,
  address: "10 Downing Street, London, SW1A 2AA",
  tenant: tenant_1
})

# Job at stage 1 - Landlord Selecting Contractor

job_lights = Job.create! ({
  property: property_1,
  category: "electrician",
  description: "There was a big bang when I turned my bedroom light on and now none of the lights upstairs will turn on.",
  current_stage: 1
})

lights_job_stage = 0

1.times do
  JobStage.create! ({
    job: job_lights,
    stage: lights_job_stage += 1
  })
end

# Job at stage 3 - Landlord Reviewing Quotes

job_tv = Job.create! ({
  property: property_1,
  category: "electrician",
  description: "My TV won't turn on",
  current_stage: 3
})

quote_tv_1 = Quote.create! ({
  contractor: contractor_1,
  job: job_tv,
  remote_quote_url_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 100,
  submitted: true
})

quote_tv_2 = Quote.create! ({
  contractor: contractor_2,
  job: job_tv,
  remote_quote_url_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 150,
  submitted: true
})

quote_tv_3 = Quote.create! ({
  contractor: contractor_3,
  job: job_tv,
  remote_quote_url_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 200,
  submitted: true
})

tv_job_stage = 0

3.times do
  JobStage.create! ({
    job: job_tv,
    stage: tv_job_stage += 1
  })
end
# Job at stage 5 - Tenant selecting date and times

job_sockets = Job.create! ({
  property: property_1,
  category: "electrician",
  description: "My sockets are full of mice",
  contractor: contractor_1,
  current_stage: 5,
  final_price: 100
})

quote_sockets_1 = Quote.create! ({
  contractor: contractor_1,
  job: job_sockets,
  remote_quote_url_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 100,
  submitted: true,
  accepted: true
})

quote_sockets_2 = Quote.create! ({
  contractor: contractor_2,
  job: job_sockets,
  remote_quote_url_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 150,
  submitted: true,
  accepted: false
})

quote_sockets_3 = Quote.create! ({
  contractor: contractor_3,
  job: job_sockets,
  remote_quote_url_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 200,
  submitted: true,
  accepted: false
})

3.times do
  ContractorAvailability.create! ({
    contractor: contractor_1,
    job: job_sockets,
    date_available: Date.today + (1..100).to_a.sample
  })
end

sockets_job_stage = 0

5.times do
  JobStage.create! ({
    job: job_sockets,
    stage: sockets_job_stage += 1
  })
end

# Job at stage 8 - Final Review

job_hoover = Job.create! ({
  property: property_1,
  category: "electrician",
  description: "I don't know how to turn my hoover off, it's really loud",
  contractor: contractor_2,
  current_stage: 8,
  final_price: 150,
  resolved: true,
  remote_invoice_url_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709664/ohkjr1mehg1bisbuuq8e.pdf",
  rating: 4
})

quote_hoover_1 = Quote.create! ({
  contractor: contractor_1,
  job: job_hoover,
  remote_quote_url_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 100,
  submitted: true,
  accepted: false
})

quote_hoover_2 = Quote.create! ({
  contractor: contractor_2,
  job: job_hoover,
  remote_quote_url_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 150,
  submitted: true,
  accepted: true
})

quote_hoover_3 = Quote.create! ({
  contractor: contractor_3,
  job: job_hoover,
  remote_quote_url_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 200,
  submitted: true,
  accepted: false
})

3.times do
  ContractorAvailability.create! ({
    contractor: contractor_2,
    job: job_hoover,
    date_available: Date.today + (1..100).to_a.sample
  })
end

hoover_job_stage = 0

8.times do
  JobStage.create! ({
    job: job_hoover,
    stage: hoover_job_stage += 1
  })
end
