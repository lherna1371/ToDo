class UsersController < ApplicationController
	before_filter :require_user
	
	def index

	end 

	def show 


	end 


	def dashboard 
		response = HTTParty.get(
		   	"http://recruiting-api.nextcapital.com/users/#{session[:passid]}/todos.json?api_token=#{session[:passtoken]}"
		)
		@result = response.body
		respond_to do |format|
		   format.json { render :json => JSON.parse(@result) }
		   format.html { render "dashboard.html.erb" }
		end
	end 

end 