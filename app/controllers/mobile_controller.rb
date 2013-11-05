class MobileController < ApplicationController

	

	def addFriend

		# 0: ok
		# 1: bad request missing info
		# 2: friend doesnt exist
		# 3: already added

		checkTimeOut()
		if (!(params[:userid].present? && params[:friendemail].present?))
			json = {'success' => false , 'errorcode' => 1}
			respond_to do |format|
				format.json { render json: json}
			end
		 else 
			id = params[:userid]
			email = params[:friendemail].strip
			friendid = getIdFromMail(email)
			if (friendid!=false)
				success = addFriendRequest(id, friendid)
				if (success)
					json = {'success' => true , 'errorcode' => 0}
					respond_to do |format|
						format.html { render json: json }
						format.json { render json: json}
					end
				else 
					json= {'success' => false , 'errorcode' => 3}
					respond_to do |format|
						format.html { render json: json }
						format.json { render json: json}
					end
				end
			else 
				json = {'success' => false , 'errorcode' => 2}
				respond_to do |format|
					format.html { render json: json }
					format.json { render json: json}
				end
		 	end
		end
	end



	def confirmFriend
	# 0: ok
	# 1: bad request missing info

		checkTimeOut()
		if (!((params[:userid].present?) && (params[:friendid].present?)))
			json = {'success' => false , 'errorcode' => 1}
			respond_to do |format|
				format.html { render json: json }
				format.json { render json: json}
			end
		else 
			id = params[:userid]
			friendid = params[:friendid]
			acceptFriendRequest(id, friendid)
			json = {'success' => true , 'errorcode' => 0 , 'id' => friendid }
			respond_to do |format|
				format.html { render json: json }
				format.json { render json: json}
			end
		end	
	end


	def declineFriend
	# 0: ok
	# 1: bad request missing info
		
		checkTimeOut()
		if (!((params[:userid].present?) && (params[:friendid].present?)))
			json = {'success' => false , 'errorcode' => 1}
			respond_to do |format|
				format.html { render json: json }
				format.json { render json: json}
			end
		else 
			id = params[:userid]
			friendid = params[:friendid]
			declineFriendRequest(id, friendid)
			json = {'success' => true , 'errorcode' => 0 }
			respond_to do |format|
				format.html { render json: json }
				format.json { render json: json}
			end
		end	
	end

	def deleteFriend
	#	0: ok
	# 1: bad request missing info

		checkTimeOut()
		if (!((params[:userid].present?) && (params[:friendids].present?)))
			json = {'success' => false , 'errorcode' => 1}
			respond_to do |format|
				format.html { render json: json }
				format.json { render json: json}
			end
		else 
			id = params[:userid]
			friends= Array.new
			deleted= Array.new
			friends.push(friendids.split(",")[0])
			friends.push(friendids.split(",")[1])
			friends.each do |friendid|
				deleteFriend(id, friendid)
				deleted.push({"id" => friendid}.to_json)
			end
			json = {'success' => true , 'errorcode' => 0, 'deleted' => deleted }
			respond_to do |format|
				format.html { render json: json }
				format.json { render json: json}
			end
		end
	end

	def getFriendList
	# 1: id non settato

		checkTimeOut()
		if (!(params[:id].present?))
			json = {'success' => false , 'errorcode' => 1}
			respond_to do |format|
				format.json { render json: json}
				format.html { render json: json }
			end
		else
			retrieveFL(params[:id])
		end		
	end

	def locationUpdate
	# 0: ok
	# 1: something not set/bad request parameters

		checkTimeOut()
		if (!((params[:id].present?) && (params[:latitude].present?) && (params[:longitude].present?)))
			json = {'success' => false , 'errorcode' => 1}
			respond_to do |format|
				format.html { render json: json }
				format.json { render json: json}
			end
		else
			id = params[:id]
			latitude = params[:latitude]
			longitude = params[:longitude]
			updateLocation(id, latitude, longitude)
			retrieveFL(params[:id])
		end
	end

	def signin
	# 0: ok
	# 1: something not set/bad request parameters
	# 2: wrong combination email/pwd

		checkTimeOut()
		if (!((params[:email].present?) && (params[:pwd].present?)))
			data= Array.new
			data.push({'email' => isEmpty(params[:email]), 'pwd' => isEmpty(params[:pwd])}.to_json)
			json = {'success' => false , 'errorcode' => 1, 'data' => data}
			respond_to do |format|
				format.html { render json: json}
				format.json { render json: json}
			end
		else 
			email = (params[:email].strip)
			pwd = params[:pwd]
			info = checkSignIn(email, pwd)
			if (info!=false)
				#updateOnlineStatus(info[0]);
				json = {
				'success' => true ,
				'errorcode' => 0 ,
				'id' => info[0] ,
				'name' => info[1],
				'surname' => info[2],
				'haveimage' => info[3],
				'mail' => email
				}
				respond_to do |format|
					format.html { render json: json}
					format.json { render json: json}
				end
			else 
				json = {
				'success' => false ,
				'errorcode' => 2
				}
				respond_to do |format|
					format.html { render json: json}
					format.json { render json: json}
				end
			end
		end
	end

	def signup
	# 0: ok
	# 1: something not set/bad request parameters
	# 2: email already used
		
		checkTimeOut()
		if (!((params[:email].present?) && (params[:pwd].present?) && (params[:name].present?) && (params[:surname].present?)))
			data= Array.new
			data.push({'email' => isEmpty(params[:email]), 'pwd' => isEmpty(params[:pwd]), 'name' => isEmpty(params[:name].strip), 'surname' => isEmpty(params[:surname].strip)}.to_json)
			json = {'success' => false , 'errorcode' => 1, 'data' => data}
			respond_to do |format|
				format.html { render json: json}
				format.json { render json: json}
			end
		else 
			name = params[:name].strip
			surname = params[:surname].strip
			email = params[:email].strip
			pwd = params[:pwd].strip
			if (isAvailableEmail(email))
				encrypted_password = Friend.new(:password => pwd).encrypted_password
				id = insertNewUser(name, surname, email, pwd)
				json = {'success' => true ,'errorcode' => 0 ,'id' => id,'name' => name,'surname' => surname,'mail' => email}
				respond_to do |format|
					format.html { render json: json}
					format.json { render json: json}
				end
			else
				json = {
				'success' => false ,
				'errorcode' => 2
				}
				respond_to do |format|
					format.html { render json: json}
					format.json { render json: json}
				end
			end
		end
	end



	def updateInfo
	# 0: ok
	# 1: missing id
	# 2: name/surename not valid
	# 3: rollback
		
		checkTimeOut()
		if (!((params[:id].present?) && (params[:name].present?) && (params[:surname].present?)))
			json = {'success' => false , 'errorcode' => 1}
			respond_to do |format|
				format.html { render json: json}
				format.json { render json: json}
			end
		else
			id = params[:id]
			name = params[:name].strip
			surname = params[:surname].strip
			if (name!="" && surname!="")
				if (updateUserInfo(id, name, surname))
					json = {'success' => true, 'errorcode' => 0, 'name' => name, 'surname' => surname}
					respond_to do |format|
						format.html { render json: json}
						format.json { render json: json}
					end
				else
					json = {'success' => false, 'errorcode' => 3, 'name' => name, 'surname' => surname}
					respond_to do |format|
						format.html { render json: json}
						format.json { render json: json}
					end
				end
			else
				json = {'success' => false, 'errorcode' => 2}
				respond_to do |format|
					format.html { render json: json}
					format.json { render json: json}
				end
			end
		end
	end

	def uploadImage
	#0: ok
	#1: id non settato
	#2: errore nell'upload dell'immagine
	#3: estensione non valida

		checkTimeOut()
		if (!params[:id].present?)
			json = {'success' => false , 'errorcode' => 1}
			respond_to do |format|
				format.html { render json: json}
				format.json { render json: json}
			end
		else
			id= params[:id]
			extension = "png"
			if (extension != "png" && extension != "jpeg" && extension != "jpg")
				json = {'success' => false , 'errorcode' => 3}
				respond_to do |format|
					format.html { render json: json}
					format.json { render json: json}
				end
			else
				s3 = AWS::S3.new(
										    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
										    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
										    :s3_endpoint => 's3-us-west-2.amazonaws.com'
												)
				
				image = params[:image]

				bucket = s3.buckets['friendmap']
				small= image
				name = "user_".concat(id.to_s).concat(".png")
				obj = bucket.objects['app/public/listimages/small/'.concat(name)].write(small.read)
				obj = bucket.objects['app/public/listimages/original/'.concat(name)].write(small.read)

				medium = MiniMagick::Image.open(image.path)
				medium.resize "256x256"
				medium.write("medium.png")
				obj = bucket.objects['app/public/listimages/medium/'.concat(name)].write("./medium.png")

				navbar = MiniMagick::Image.open(image.path)
				navbar.resize "35x35"
				navbar.write("navbar.png")
				obj = bucket.objects['app/public/listimages/navbar/'.concat(name)].write(file: => "navbar.png")


				 #f1=Friend.find(id)
				 #uploaded_io = params[:image]
				 #f1.picture = uploaded_io
				 #f1.update_attributes(:picture => params[:image])
				
				#S3Object.store('me.jpg', open(params[:image]), 'friendmap')
				
				# uploaded_io = params[:image].tmpfile
				# File.open("https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/small/".concat(params[:image].original_filename), 'w') do |file|
			    # file.write(uploaded_io.read)
			    # file.close
			  #end
			  if(incrementImageNumber(id))
			  	
				  json = {'success' => true , 'errorcode' => 0}
					respond_to do |format|
						format.html { render json: json}
						format.json { render json: json}
					end
				else
					json = {'success' => true , 'errorcode' =>4}
					respond_to do |format|
						format.html { render json: json}
						format.json { render json: json}
					end
				end
			end
		end	
	end



	# private functions (ex dbconnect.php)


	private
		def isAvailableEmail (emailt)
		  if(Friend.where(:email => emailt).blank?)
		  	return true
		  else
		  	return false
		  end
		end

		def isEmpty (string)
			if (string=="")
				return true
			else
				return false
			end
		end

		def retrieveFL (id)
			friendships= Friendship.where(:friend_id => id).pluck(:otherfriend)
			friends = Array.new
			users = Array.new			

			if (friendships.size >0)

				friendships.each do |fs|
					friends.push(Friend.find(fs))			
					if (friends.last.isonline=="true")
						online="true"
						if(!(friends.last.latitude == nil && friends.last.longitude == nil))
							latitude= "".concat(friends.last.latitude.to_s)
							longitude= "".concat(friends.last.longitude.to_s)
						else
							latitude = "0"
							longitude = "0"
						end
					else
						online = "flase"
						if(!(friends.last.latitude == nil && friends.last.longitude == nil))
							latitude = "0"
							longitude = "0"
						end
					end

					users.push({
					'id' => friends.last.id ,
					'name' => friends.last.name,
					'surname' => friends.last.surname ,
					'mail' => friends.last.email ,
					'online' => online ,
					'datanumber' => friends.last.datanumber ,
					'imagenumber' => friends.last.imagenumber ,
					'latitude' => latitude ,
					'longitude' => longitude})
				end
			end

			
			requesters = Array.new
			requests= FriendRequest.where(:otherfriend => id).pluck(:friend_id)
			if (requests.size>0)

				requestersTmp = Array.new

				requests.each do |rs|
					requestersTmp.push(Friend.find(rs))
					
					
					requesters.push({
					'id' => requestersTmp.last.id ,
					'name' => requestersTmp.last.name,
					'surname' => requestersTmp.last.surname ,
					'mail' => requestersTmp.last.email ,
					'datanumber' => requestersTmp.last.datanumber ,
					'imagenumber' => requestersTmp.last.imagenumber})
				end
			end
			json = {'success' => true , 'errorcode' => 0, 'friends' => users, 'requests' => requesters}
				respond_to do |format|
				format.html { render json: json}
				format.json { render json: json}
			end	
		end

		def insertNewUser(name, surname, email, pwd)
			newUser= Friend.new()
			newUser.name = name
			newUser.surname = surname
			newUser.email = email
			newUser.password = pwd
			newUser.password_confirmation=pwd
			

			
	    if (newUser.save!)
	      return newUser.id
	    else
	      return false
	    end
		end

		def incrementImageNumber(id)
			friend = Friend.find(id)
			count = 0
			
			if(friend.imagenumber==nil || friend.imagenumber==0)
    		count=1
    	else
    		count=friend.imagenumber+1
    	end
      if friend.update_attributes(:imagenumber => count)
        success = true
	      return success
	    else
	    	success = false
	      return success
	    end
		end

		def updateUserInfo(id, name, surname)
			friend = Friend.find(id)
			count = 0
			
			if(friend.datanumber==nil || friend.datanumber==0)
    		count=1
    	else
    		count=friend.datanumber+1
    	end

	    if friend.update_attributes(:name => name, :surname => surname, :datanumber => count) # HOPE
	    	success = true
	      return success
	    else
	    	success = false
	      return success
	    end
		end

		def getIdFromMail(email)
			friend=Friend.where(:email => email).last
			if (friend != nil)
				return friend.id
			else
				return false	
			end
		end
	
		def addFriendRequest(friend_id, otherfriend)
			fr= FriendRequest.where("friend_id = ? AND otherfriend = ?", friend_id, otherfriend).last
			if (fr==nil)
				fs= Friendship.where("friend_id = ? AND otherfriend = ?", friend_id, otherfriend).last
				if (fs==nil)
					fr2=FriendRequest.new
					fr2.friend_id = friend_id
					fr2.otherfriend = otherfriend
					if (fr2.save)
						return true
					else
						return false
					end
				else
					return false						
				end
			else
				return false
			end
		end

		def acceptFriendRequest(otherfriend, friend_id)
			frequest = FriendRequest.where("friend_id = ? AND otherfriend = ?", friend_id, otherfriend).last
    	frequest.destroy

    	fs1 = Friendship.new
    	fs1.friend_id = friend_id
    	fs1.otherfriend = otherfriend

    	fs2 = Friendship.new
    	fs2.friend_id = otherfriend
    	fs2.otherfriend = friend_id

    	fs1.save
    	fs2.save
		end

		def declineFriendRequest(otherfriend, friend_id)
			frequest = FriendRequest.where("friend_id = ? AND otherfriend = ?", friend_id, otherfriend).last
    	frequest.destroy
		end

		def deleteFriend(otherfriend, friend_id)
			fship = Friendship.where("friend_id = ? AND otherfriend = ?", friend_id, otherfriend).last
    	fship.destroy
		end

		def checkSignIn(email, pwd)
			friend= Friend.where("email = ?", email).last
			if (friend == nil)
				return false
			else
				if (!friend.valid_password?(pwd))
					return false
				else
					array= Array.new
					array.push(friend.id, friend.name, friend.surname, (friend.imagenumber.to_i > 1))
					return array
				end
			end
		end

		def checkTimeOut()
			Friend.all.each do |f|
				if (f.lastseen == nil)
					f.update_attributes(:isonline => "false")
				else
					if ((Time.now - f.lastseen)/1.minute > 8)
						f.update_attributes(:isonline => "false")
					else
						f.update_attributes(:isonline => "true")
					end
				end
			end
		end

		def updateLocation(id, latitude, longitude)
			friend=Friend.find(id)
			submission_hash={
												"latitude" => latitude,
												"longitude" => longitude,
												"lastseen" => Time.now,
												"isonline" => "true"}
			friend.update_attributes(submission_hash) # HOPE
		end

				
end

#end?
