Message.destroy_all
ContractorAvailability.destroy_all
PhotoVideo.destroy_all
Quote.destroy_all
JobStage.destroy_all
Job.destroy_all
Property.destroy_all
User.destroy_all

tenant_1 = User.create! ({
  first_name: "Tom",
  last_name:"Dove",
  email: "tom@gmail.com",
  password: 123456,
  remote_avatar_url: "https://kitt.lewagon.com/placeholder/users/dovet1",
  user_type: "tenant"
})

landlord_1 = User.create! ({
  first_name: "Corrie",
  last_name: "Mosely",
  email: "corrie@gmail.com",
  password: 123456,
  remote_avatar_url: "https://kitt.lewagon.com/placeholder/users/corrieam",
  user_type: "landlord"
})

contractor_1 = User.create! ({
  first_name: "Liam",
  last_name: "Garrison",
  email: "liam@gmail.com",
  password: 123456,
  remote_avatar_url: "https://kitt.lewagon.com/placeholder/users/liamgarrison",
  user_type: "contractor",
  contractor_type: "electrical"
})

contractor_2 = User.create! ({
  first_name: "Luca",
  last_name: "Kuhn",
  email: "luca@gmail.com",
  password: 123456,
  remote_avatar_url: "https://kitt.lewagon.com/placeholder/users/lucakuhn1912",
  user_type: "contractor",
  contractor_type: "electrical"
})

contractor_3 = User.create! ({
  first_name: "Julius",
  last_name: "Lehmann",
  email: "miguel@gmail.com",
  password: 123456,
  remote_avatar_url: "https://kitt.lewagon.com/placeholder/users/jcslehmann",
  user_type: "contractor",
  contractor_type: "electrical"
})

contractor_4 = User.create! ({
  first_name: "Che",
  last_name: "To",
  email: "che@gmail.com",
  password: 123456,
  remote_avatar_url: "https://kitt.lewagon.com/placeholder/users/cheeto1",
  user_type: "contractor",
  contractor_type: "plumbing"
})

contractor_5 = User.create! ({
  first_name: "David",
  last_name: "Gordon",
  email: "david@gmail.com",
  password: 123456,
  remote_avatar_url: "https://kitt.lewagon.com/placeholder/users/davidgordon2211",
  user_type: "contractor",
  contractor_type: "plumbing"
})

property_1 = Property.create! ({
  landlord: landlord_1,
  address: "138 Kingsland Road, London",
  tenant: tenant_1
})


# Job at stage 5 - Tenant selecting date and times

job_fusebox = Job.create! ({
  property: property_1,
  category: "electrical",
  description: "My power keeps going out and my fuse box is tripping",
  contractor: contractor_1,
  current_stage: 1,
})

PhotoVideo.create(
  job: job_fusebox,
  stage: 1,
  remote_photo_video_url: 'https://www.localelectriciansdirect.co.uk/sites/www.localelectriciansdirect.co.uk/files/styles/gallery_image/public/Electric%20Problems.jpg?itok=SIjwbNbJ'
)

quote_fusebox_1 = Quote.create! ({
  contractor: contractor_1,
  job: job_fusebox,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 175,
  submitted: true,
  accepted: true
})

quote_fusebox_2 = Quote.create! ({
  contractor: contractor_2,
  job: job_fusebox,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 150,
  submitted: true,
  accepted: false
})

quote_fusebox_3 = Quote.create! ({
  contractor: contractor_3,
  job: job_fusebox,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 200,
  submitted: true,
  accepted: false
})

3.times do |index|
  ContractorAvailability.create! ({
    contractor: contractor_1,
    job: job_fusebox,
    date_available: [Date.today+ 2, Date.today + 4, Date.today + 8][index]
  })
end

job_fusebox.update(current_stage: 2)
job_fusebox.update(current_stage: 3)
job_fusebox.update(current_stage: 4)
job_fusebox.update(current_stage: 5)

# Job at stage 7 - waiting for tenant feedback

job_tap = Job.create! ({
  property: property_1,
  category: "plumbing",
  description: "My tap is leaking and spraying water everywhere!",
  contractor: contractor_5,
  current_stage: 1,
  final_price: 200,
  remote_invoice_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709664/ohkjr1mehg1bisbuuq8e.pdf",
  date: Date.today + 5
})

PhotoVideo.create(
  job: job_tap,
  stage: 1,
  remote_photo_video_url: 'https://www.reicheltplumbing.com/images/broken-sink.jpg'
)

quote_tap_1 = Quote.create! ({
  contractor: contractor_4,
  job: job_tap,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 170,
  submitted: true,
  accepted: false
})

quote_tap_2 = Quote.create! ({
  contractor: contractor_5,
  job: job_tap,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 190,
  submitted: true,
  accepted: true
})


4.times do |index|
  ContractorAvailability.create! ({
    contractor: contractor_5,
    job: job_tap,
    date_available: [Date.today+ 1, Date.today+ 3, Date.today + 5, Date.today + 9][index]
  })
end

job_tap.update(current_stage: 2)
job_tap.update(current_stage: 3)
job_tap.update(current_stage: 4)
job_tap.update(current_stage: 5)
job_tap.update(current_stage: 6)
job_tap.update(current_stage: 7)

# Job completed at stage 9

job_toilet = Job.create! ({
  property: property_1,
  category: "plumbing",
  description: "My sink is blocked and it won't drain properly",
  contractor: contractor_4,
  current_stage: 1,
  final_price: 200,
  remote_invoice_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709664/ohkjr1mehg1bisbuuq8e.pdf",
  rating: 5,
  date: Date.today + 7
})

PhotoVideo.create(
  job: job_toilet,
  stage: 1,
  remote_photo_video_url: 'https://metropha.com/wp-content/uploads/2018/12/The-Dreadful-Consequences-of-a-Clogged-Drain-_-Plumber-in-Cleveland-TN.jpg'
)

quote_tap_1 = Quote.create! ({
  contractor: contractor_4,
  job: job_toilet,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 180,
  submitted: true,
  accepted: true
})

quote_tap_2 = Quote.create! ({
  contractor: contractor_5,
  job: job_toilet,
  remote_quote_url: "https://res.cloudinary.com/dzxwfflob/image/upload/v1558709144/ycdegazxv9w8boqz3p8a.pdf",
  price: 210,
  submitted: true,
  accepted: false
})


5.times do |index|
  ContractorAvailability.create! ({
    contractor: contractor_4,
    job: job_toilet,
    date_available: [Date.today+ 1, Date.today+ 3, Date.today + 7, Date.today + 9, Date.today + 11][index]
  })
end

job_toilet.update(current_stage: 2)
job_toilet.update(current_stage: 3)
job_toilet.update(current_stage: 4)
job_toilet.update(current_stage: 5)
job_toilet.update(current_stage: 6)
job_toilet.update(current_stage: 7)
job_toilet.update(current_stage: 8)
job_toilet.update(current_stage: 9)
