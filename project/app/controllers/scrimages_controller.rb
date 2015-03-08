class ScrimagesController < ApplicationController
	before_action :logged_in_user, only: [:new_scrimage, :update]

	def show
		@scrimage = Scrimage.find(params[:id])
		@remainingSeconds = remaining_time(@scrimage)
		@votingRemainingSeconds = voting_time(@scrimage)

		@original_photo = Photo.where("scrimage_id = ? AND parent_photo_id = ?", @scrimage.id, -1).first

		@numWinnerVotes = @scrimage.photos.order("votes DESC").first.votes

		@winningPhotos =  @scrimage.photos.where("votes == ? AND parent_photo_id != ?", @numWinnerVotes, -1)

		# @photos = Photo.where("scrimage_id = ? AND parent_photo_id != ?", @scrimage.id, -1)
	end

	def new_scrimage
	end

	def create
		isTimed = 0
		start_time = DateTime.now
		end_time = start_time

		if params[:type] == "timed"
			isTimed = 1
			end_time = end_time + 5
		end

		scrimage = Scrimage.new(:name => params[:name], :timed=> isTimed, :start_time => start_time, :end_time => end_time, :description => params[:description])
		scrimage.save()

		if scrimage.id
			uploaded_io = params[:original_photo]
			File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
	    			file.write(uploaded_io.read)
	  		end

			originalPhoto = Photo.new(:filename => "/images/" + params[:original_photo].original_filename, :description => params[:description], :user_id => current_user.id, :scrimage_id => scrimage.id)

			originalPhoto.save()

			if originalPhoto.id
				redirect_to :action => "show", :id => scrimage.id
			else
				render :action => "new_scrimage"
			end

		else
			render :action => "new_scrimage"
		end
	end

	def uploadEditedImage
		puts params[:editedPhoto]
  		puts "------------------------------"

		uploaded_io = params[:editedPhoto]
		File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
    			file.write(uploaded_io.read)
  		end

	  	newPhoto = Photo.new(:filename => "/images/" + uploaded_io.original_filename, :description => params[:editedPhotoText], :user_id => current_user.id, :scrimage_id => params[:scrimage_id], :parent_photo_id => params[:parent_photo_id])
	  	newPhoto.save()

	  	scrimage = Scrimage.find(params[:scrimage_id])

		render :partial => "displayChildPhotos", :locals => {:scrimage => scrimage, :remainingTime => remaining_time(scrimage), :votingTime => voting_time(scrimage)}
	end

	def set_winner
		respond_to do |format|
			format.json{
				scrimage = Scrimage.find(params[:scrimage_id])
				winningPhotoID = scrimage.photos.order("votes DESC").first.id
				scrimage.winner_id = winningPhotoID
				scrimage.save()
				render :json => {:winningPhotoID => winningPhotoID}  
  			}			
  		end
	end
	
	# Before filters

    def logged_in_user # Confirms user is logged in
      unless logged_in?
        flash[:error] = "Please log in"
        redirect_to login_url
      end
    end
end