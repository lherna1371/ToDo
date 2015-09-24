class TodoController < ApplicationController
	skip_before_action :verify_authenticity_token


	def index 
		# /users/:user_id/todos/:id
		puts response = HTTParty.get(
		   	"http://recruiting-api.nextcapital.com/users/#{session[:passid]}/todos/#{params[:editID]}?api_token=#{session[:passtoken]}"
		)
		@itemreturn = response.body
		respond_to do |format|
		   format.json { render :json => JSON.parse(@itemreturn) }
		   format.html { render "users/dashboard.html.erb" }
		end
	end 


	def create
		response = HTTParty.post(
		   	"http://recruiting-api.nextcapital.com/users/#{session[:passid]}/todos",
		  	:body => { :api_token => session[:passtoken], 
		  		:user_id => session[:passid],
		  		:todo => {"description" => "#{params[:item].gsub(/'/,"")}"}
	            }.to_json, 
		  	:headers => { 'Content-Type' => 'application/json' } 
		)
		@return = response.body
		respond_to do |format|
		   format.json { render :json => JSON.parse(@return) }
		   format.html { render "user/dashboard.html.erb" }
		end
	end 


	def edit 
		if params[:edititem].present?
			response = HTTParty.put(
			   	"http://recruiting-api.nextcapital.com/users/#{session[:passid]}/todos/#{params[:todoID]}",
			  	:body => { :api_token => session[:passtoken], 
			  		:user_id => session[:passid],
			  		:todo => {"description" => "#{params[:edititem].gsub(/'/,"").strip}"}
		            }.to_json, 
			  	:headers => { 'Content-Type' => 'application/json' } 
			) 
			redirect_to '/user/dashboard'
		else 
			response = HTTParty.put(
			   	"http://recruiting-api.nextcapital.com/users/#{session[:passid]}/todos/#{params[:todoID]}",
			  	:body => { :api_token => session[:passtoken], 
			  		:user_id => session[:passid],
			  		:todo => {"is_complete" => true}
		            }.to_json, 
			  	:headers => { 'Content-Type' => 'application/json' } 
			) 
			@return = response.body
			respond_to do |format|
			   format.json { render :json => JSON.parse(@return) }
			   format.html { render "todo/edit.html.erb" }
			end
		end 
	end 

	def edit_todo
		response = HTTParty.get(
		   	"http://recruiting-api.nextcapital.com/users/#{session[:passid]}/todos/#{params[:id]}?api_token=#{session[:passtoken]}"
		)
		@return = response.body
		respond_to do |format|
		   format.json { render :json => JSON.parse(@return) }
		   format.html { render "todo/edit_todo.html.erb" }
		end
	end 

end 