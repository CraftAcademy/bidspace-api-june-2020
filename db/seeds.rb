Listing.destroy_all
User.destroy_all

user = User.create(email: 'user@mail.com', password: 'password', role:'registered')
subscriber = User.create(email: 'subscriber@mail.com', password: 'password', role:'subscriber')

free_listing_1 = Listing.create(
  category: 'Parking spot',
  lead: 'Takes less than 1 minute to get the metro',
  scene: 'outdoor',
  description: "The parking spot is available for one week from 3rd of October, 2020",
  address: 'Sveavägen 59, 113 59 Stockholm',
  price: '100',
  landlord_id: user.id
)
file = URI.open('https://lh3.googleusercontent.com/proxy/VQLmmRPZnaiTDNKwtEmDQ1lfPIFpARjMwe4GmjVZcwBRyKBluPpWi272qJrYwmt-DlKPHiU6FJzIdShEQJXyuiiEkCt1Se_tCAfsQl8xLg1YGXW2cJCClagxb_cZ1jsZsY3TtvYtJd4e-_CxcLFTwQtQELPIXD25aVeAWaCTZhZXUj0')
free_listing_1.images.attach(io: file, filename: 'first.jpg')
file = URI.open('https://www.apartdirect.com/media/2279/iaparthotel-stockholm-city-center-apartdirect-sveavagen.jpeg')
free_listing_1.images.attach(io: file, filename: 'second.jpg')

free_listing_2 = Listing.create(
  category: 'Parking spot',
  lead: 'Safe area and easy access',
  scene: 'outdoor',
  description: "The parking is accessible for between 20th and 25th of Sepetember, 2020. the price is daily basis",
  address: 'Högbergsgatan 21 11620 Stockholm',
  price: '80',
  landlord_id: user.id
)
file = URI.open('https://www.pymnts.com/wp-content/uploads/2018/03/parkingspot.jpg')
free_listing_2.images.attach(io: file, filename: 'third.jpg')
file = URI.open('https://media-cdn.tripadvisor.com/media/photo-p/11/ab/d9/40/osynlig-utstallning-stockholm.jpg')
free_listing_2.images.attach(io: file, filename: 'fourth.jpg')

premium_listing_1 = Listing.create(
  category: 'Parking spot',
  lead: 'Close to the city center',
  scene: 'indoor',
  description: 'You could rent the parking out for 3 month this winter, 2020',
  address: 'Brunkebergstorg 9, 111 51 Stockholm',
  price: '700',
  landlord_id: subscriber.id
)
file = URI.open('https://media-cdn.tripadvisor.com/media/photo-s/19/33/07/06/scandic-hamburg-emporio.jpg')
premium_listing_1.images.attach(io: file, filename: 'fifth.jpg')
file = URI.open('https://sc02.alicdn.com/kf/HTB1l951ckfb_uJkSmLyq6AxoXXao/200480468/HTB1l951ckfb_uJkSmLyq6AxoXXao.jpg_.webp')
premium_listing_1.images.attach(io: file, filename: 'sixth.jpg')

premium_listing_2 = Listing.create(
  category: 'Parking spot',
  lead: 'Need a safe parking to park your car when you dont need that for a week',
  scene: 'indoor',
  description: 'The parking is available for a week from 25th of December till 3rd of January' ,
  address: 'Settergatan 14 11548 Stockholm',
  price: '300',
  landlord_id: subscriber.id
)
file = URI.open('https://www.atlanticenter.com/wp-content/uploads/2019/04/indoor-parking-spaces-to-rent-milan-atlantic-business-center-milan-3-1.jpg')
premium_listing_2.images.attach(io: file, filename: 'seventh.jpg')
file = URI.open('https://www.atlanticenter.com/wp-content/uploads/2019/04/indoor-parking-spaces-to-rent-milan-atlantic-business-center-milan-4-2.jpg')
premium_listing_2.images.attach(io: file, filename: 'eighth.jpg')