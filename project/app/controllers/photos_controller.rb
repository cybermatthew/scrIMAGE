class PhotosController < ApplicationController

	def index
		@photos = Photo.all
	end

	def show
		@user_id = session[:id]
		@loggedIn = true

		if @user_id.nil?
			@loggedIn = false
		end

		@error = false

		# checks if photo id is given and photo exists in db
		if !params.has_key?(:id) || !Photo.exists?(params[:id])
			flash.now[:notice] = "The selected photo does not exist on the site"
			@error = true
		else
			@photo = Photo.find(params[:id])
			@user = User.find(@photo.user_id)
			@comments = Comment.where(:photo_id => params[:id])
		end
		# @photos = Photo.all
	end

	def create_comment
		comment = Comment.new(:photo_id => params[:photo_id], :user_id => current_user.id, :text => params[:text])
		comment.save()

		user = User.find(comment.user_id)

		render :partial => "create_comment", :locals => {:comment => comment, :user => user}
	end

	def save_edited_photo
		require "open-uri"

		respond_to do |format|
			format.json{
				photoName = params[:editedPhotoLink]
				image_from_web  = open(photoName) {|f| f.read }
				file_name = photoName.split("/").pop()
				rootDir = Rails.root.join("public/images", file_name)
				File.open(rootDir, 'wb') do |f| 
					f.write(image_from_web) 
				end
		
				photo = Photo.new(:filename => "/images/" + file_name, :user_id => current_user.id, :scrimage_id => params[:scrimage_id], :parent_photo_id => params[:parent_photo_id])
				photo.save()
 				@scrimage = Scrimage.find(params[:scrimage_id])
				render :json => {:html => render_to_string({:partial => "scrimages/displayChildPhotos", :formats => [:html, :js], :locals => {:scrimage => @scrimage}, :layout => false})}  
  			}			
  		end
	end

	def draw_tree
		photo = Photo.find(params["photo_id"])

		if photo.parent_photo_id != -1
			parentPhoto = Photo.find(photo.parent_photo_id)
		end

		originalPhoto = Photo.where("parent_photo_id = ? AND scrimage_id = ?", -1, photo.scrimage_id).first
		childPhotos = Photo.where("parent_photo_id = ?", photo.id)

		render :partial => "draw_tree", :locals => {:originalPhoto => originalPhoto, :curPhoto => photo, :parentPhoto => parentPhoto, :childPhotos => childPhotos}
	end

	def getPhotoForTree
		nextPhoto = Photo.find(params[:photo_id])

		render :partial => "addPhotoToTree", :locals => {:addedPhoto => nextPhoto, :original_photo_id => params[:original_photo_id]}
	end

	private
	## Strong Parameters
	def photo_params
		params.require(:photo).permit(:filename, :description, :votes, :user_id, :scrimage_id, :parent_photo_id)
	end

	def comment_params
		params.require(:comment).permit(:photo_id, :user_id, :text, :created_at)
	end
end