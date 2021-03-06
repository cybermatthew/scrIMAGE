# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# load users #
admin_user = User.new(:username => "admin", :password => "password", :bio => "I am the admin", :profile_image => "happy-smiling-cute-corgi-dog.jpg", :points => 100)
admin_user.save(:validate => true)

# load closed scrimage #
test_scrimage = Scrimage.new(:name => "Chrysanthemum", :timed => 1, :start_time => DateTime.now-12, :end_time => DateTime.now-7, :description => "Who has the most awesome chrysanthemum editing skills?", :open_for_voting => false)
test_scrimage.save(:validate => true)

# load photos for closed scrimage #
flower = Photo.new(:filename => "/images/Chrysanthemum.jpg", :description => "Original chrysanthemum photo", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage.id)
flower.save(:validate => false)

child_photo = Photo.new(:filename => "/images/0b8e0700abbd4bcf887c8b52b899d3cf.jpg", :description => "Halp", :votes => 7, :user_id => admin_user.id, :scrimage_id => test_scrimage.id, :parent_photo_id => flower.id)
child_photo.save(:validate => false)

child_photo2 = Photo.new(:filename => "/images/83c74aa98aaf43aa9f1af99ab066ddbf.jpg", :description => "Ceci n'est pas une pipe", :votes => 5, :user_id => admin_user.id, :scrimage_id => test_scrimage.id, :parent_photo_id => flower.id)
child_photo2.save(:validate => false)

alex_user = User.new(:username => "ta alex", :password => "alex", :bio => "scrImage is my favorite 194 project!!!", :profile_image => "alex_pic.jpg", :points => 0)
alex_user.save(:validate => true)

child_photo3 = Photo.new(:filename => "/images/2047b54e939945fca25e9426c29a1eb5.jpg", :description => "Contemporary Art", :votes => 11, :user_id => alex_user.id, :scrimage_id => test_scrimage.id, :parent_photo_id => flower.id)
child_photo3.save(:validate => false)




# load scrimage in voting period #
test_scrimage2 = Scrimage.new(:name => "Bees the Duck", :timed => 1, :start_time => DateTime.now-6, :end_time => DateTime.now-1, :description => "Let's edit Bees!", :open_for_voting => true)
test_scrimage2.save(:validate => true)

# load photos for scrimage in voting period #
bees = Photo.new(:filename => "/images/bees.jpg", :description => "Bees", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage2.id)
bees.save(:validate => false)

bees_accessories = Photo.new(:filename => "/images/938e7e344fa64234b8890ea1daf08497.jpg", :description => "Bees with Accessories", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage2.id, :parent_photo_id => bees.id)
bees_accessories.save(:validate => false)

hipster_bees = Photo.new(:filename => "/images/45d2ac3bc13f433995dc3d36e0e555e6.jpg", :description => "Hipster Bees", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage2.id, :parent_photo_id => bees_accessories.id)
hipster_bees.save(:validate => false)

ultra_hipster_bees = Photo.new(:filename => "/images/6264431c3ea64bf68e0878331117a862.jpg", :description => "Ultra Hipster Bees", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage2.id, :parent_photo_id => hipster_bees.id)
ultra_hipster_bees.save(:validate => false)

what_is_bees = Photo.new(:filename => "/images/ec7b97e6a6194ffa8f6afaecace0929a.jpg", :description => "What is Bees", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage2.id, :parent_photo_id => ultra_hipster_bees.id)
what_is_bees.save(:validate => false)



# load second scrimage in voting period #
baby_scrimage = Scrimage.new(:name => "Cute Baby", :timed => 1, :start_time => DateTime.now-7, :end_time => DateTime.now-2, :description => "Why mess with adorable perfection?  BECAUSE WE CAN", :open_for_voting => true)
baby_scrimage.save(:validate => true)

baby_original = Photo.new(:filename => "/images/baby1.jpg", :description => "Cute Baby", :votes => 0, :user_id => alex_user.id, :scrimage_id => baby_scrimage.id)
baby_original.save(:validate => false)

baby_mustache = Photo.new(:filename => "/images/7c25d6c5a5f348dfbded70155716f4b3.jpg", :description => "Needing a Trim", :votes => 0, :user_id => alex_user.id, :scrimage_id => baby_scrimage.id, :parent_photo_id => baby_original.id)
baby_mustache.save(:validate => false)

baby_bowtie = Photo.new(:filename => "/images/e6c2590b1b9d4cd7acee62bfc5a0d6f0.jpg", :description => "DAPPER", :votes => 0, :user_id => alex_user.id, :scrimage_id => baby_scrimage.id, :parent_photo_id => baby_mustache.id)
baby_bowtie.save(:validate => false)

baby_hat = Photo.new(:filename => "/images/e0cbaefe75164785b3d4016c5814075b.jpg", :description => "hatz", :votes => 0, :user_id => admin_user.id, :scrimage_id => baby_scrimage.id, :parent_photo_id => baby_bowtie.id)
baby_hat.save(:validate => false)

baby_blurb = Photo.new(:filename => "/images/f5346ab5501a467ea7d65ac02518783a.jpg", :description => "WUV MY MOMMY", :votes => 0, :user_id => alex_user.id, :scrimage_id => baby_scrimage.id, :parent_photo_id => baby_hat.id)
baby_blurb.save(:validate => false)

# # load scrimage in voting period 2 #
# test_scrimage3 = Scrimage.new(:name => "Bees the Duck", :timed => 1, :start_time => DateTime.now-6, :end_time => DateTime.now-1, :description => "Let's edit Bees!", :open_for_voting => true)
# test_scrimage3.save(:validate => true)

# # load photos for scrimage in voting period 2 #
# bees2 = Photo.new(:filename => "/images/bees.jpg", :description => "Bees", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage3.id)
# bees2.save(:validate => false)

# bees3 = Photo.new(:filename => "/images/bees.jpg", :description => "Bees", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage3.id, :parent_photo_id => bees2.id)
# bees3.save(:validate => false)

# load comments #
comment = Comment.new()
comment.user_id = admin_user.id
comment.photo_id = child_photo.id
comment.text = "Love it!"
comment.save(:validate => false)