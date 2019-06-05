Message.destroy_all
ContractorAvailability.destroy_all
PhotoVideo.destroy_all
Quote.destroy_all
JobStage.destroy_all
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
  contractor_type: "electrical"
})

contractor_2 = User.create! ({
  first_name: "Sparky",
  last_name: "Anderson",
  email: "sparky@gmail.com",
  password: 123456,
  remote_avatar_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558707979/u8hld1cp17rshv2pkay6.png",
  user_type: "contractor",
  contractor_type: "electrical"
})

contractor_3 = User.create! ({
  first_name: "Miguel",
  last_name: "San Pedro",
  email: "miguel@gmail.com",
  password: 123456,
  remote_avatar_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558707971/ugszwtmxvsiyrc5xud2c.png",
  user_type: "contractor",
  contractor_type: "electrical"
})

property_1 = Property.create! ({
  landlord: landlord_1,
  address: "10 Downing Street, London, SW1A 2AA",
  tenant: tenant_1
})

# Job at stage 1 - Landlord Selecting Contractor

job_lights = Job.create! ({
  property: property_1,
  category: "electrical",
  description: "There was a big bang when I turned my bedroom light on.",
  current_stage: 1
})

PhotoVideo.create(
  job: job_lights,
  stage: 1,
  remote_photo_video_url: 'https://images.pexels.com/photos/1123262/pexels-photo-1123262.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
)

# Job at stage 3 - Landlord Reviewing Quotes

job_tv = Job.create! ({
  property: property_1,
  category: "electrical",
  description: "My TV won't turn on",
  current_stage: 1
})

PhotoVideo.create(
  job: job_tv,
  stage: 3,
  remote_photo_video_url: 'https://images.pexels.com/photos/2251206/pexels-photo-2251206.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
)


quote_tv_1 = Quote.create! ({
  contractor: contractor_1,
  job: job_tv,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 100,
  submitted: true
})

quote_tv_2 = Quote.create! ({
  contractor: contractor_2,
  job: job_tv,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 150,
  submitted: true
})

quote_tv_3 = Quote.create! ({
  contractor: contractor_3,
  job: job_tv,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 200,
  submitted: true
})

job_tv.update(current_stage: 2)
job_tv.update(current_stage: 3)

# Job at stage 5 - Tenant selecting date and times

job_sockets = Job.create! ({
  property: property_1,
  category: "electrical",
  description: "My sockets are full of mice",
  contractor: contractor_1,
  current_stage: 1,
})

PhotoVideo.create(
  job: job_sockets,
  stage: 5,
  remote_photo_video_url: 'https://images.pexels.com/photos/257736/pexels-photo-257736.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
)

quote_sockets_1 = Quote.create! ({
  contractor: contractor_1,
  job: job_sockets,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 100,
  submitted: true,
  accepted: true
})

quote_sockets_2 = Quote.create! ({
  contractor: contractor_2,
  job: job_sockets,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 150,
  submitted: true,
  accepted: false
})

quote_sockets_3 = Quote.create! ({
  contractor: contractor_3,
  job: job_sockets,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 200,
  submitted: true,
  accepted: false
})

3.times do |index|
  ContractorAvailability.create! ({
    contractor: contractor_1,
    job: job_sockets,
    date_available: [Date.today+ 2, Date.today + 4, Date.today + 8][index]
  })
end

job_sockets.update(current_stage: 2)
job_sockets.update(current_stage: 3)
job_sockets.update(current_stage: 4)
job_sockets.update(current_stage: 5)

# Job at stage 7 - waiting for tenant feedback

job_fuses = Job.create! ({
  property: property_1,
  category: "electrical",
  description: "My fuse board has blown",
  contractor: contractor_1,
  current_stage: 1,
  final_price: 75,
  remote_invoice_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709664/ohkjr1mehg1bisbuuq8e.pdf",
  rating: 5,
  date: Date.today + 5
})

PhotoVideo.create(
  job: job_fuses,
  stage: 7,
  remote_photo_video_url: 'https://images.unsplash.com/photo-1558816051-0a1efe688f41?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'
)

job_fuses_1 = Quote.create! ({
  contractor: contractor_1,
  job: job_fuses,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 75,
  submitted: true,
  accepted: true
})

job_fuses_2 = Quote.create! ({
  contractor: contractor_2,
  job: job_fuses,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 80,
  submitted: true,
  accepted: false
})

job_fuses_3 = Quote.create! ({
  contractor: contractor_3,
  job: job_fuses,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 80,
  submitted: true,
  accepted: false
})

3.times do |index|
  ContractorAvailability.create! ({
    contractor: contractor_1,
    job: job_fuses,
    date_available: [Date.today+ 2, Date.today + 4, Date.today + 8][index]
  })
end

job_fuses.update(current_stage: 2)
job_fuses.update(current_stage: 3)
job_fuses.update(current_stage: 4)
job_fuses.update(current_stage: 5)
job_fuses.update(current_stage: 6)
job_fuses.update(current_stage: 7)

# Job at stage 8 - Final Review

job_hoover = Job.create! ({
  property: property_1,
  category: "electrical",
  description: "I don't know how to turn my hoover off, it's really loud",
  contractor: contractor_2,
  current_stage: 1,
  final_price: 150,
  resolved: true,
  remote_invoice_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709664/ohkjr1mehg1bisbuuq8e.pdf",
  rating: 4,
  date: Date.today + 5
})

PhotoVideo.create(
  job: job_hoover,
  stage: 8,
  remote_photo_video_url: 'https://images.pexels.com/photos/38325/vacuum-cleaner-carpet-cleaner-housework-housekeeping-38325.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
)


quote_hoover_1 = Quote.create! ({
  contractor: contractor_1,
  job: job_hoover,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 100,
  submitted: true,
  accepted: false
})

quote_hoover_2 = Quote.create! ({
  contractor: contractor_2,
  job: job_hoover,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 150,
  submitted: true,
  accepted: true
})

quote_hoover_3 = Quote.create! ({
  contractor: contractor_3,
  job: job_hoover,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 200,
  submitted: true,
  accepted: false
})

3.times do |index|
  ContractorAvailability.create! ({
    contractor: contractor_2,
    job: job_hoover,
    date_available: [Date.today+ 2, Date.today + 4, Date.today + 8][index]
  })
end

job_hoover.update(current_stage: 2)
job_hoover.update(current_stage: 3)
job_hoover.update(current_stage: 4)
job_hoover.update(current_stage: 5)
job_hoover.update(current_stage: 6)
job_hoover.update(current_stage: 7)
job_hoover.update(current_stage: 8)

