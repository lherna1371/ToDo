class SessionsController < ApplicationController
    before_filter :require_user, :except => [:new, :sign_up, :destroy, :create, :sign_in]

  def new

  end 


  def sign_up

  end 

  def create
  	if (params[:password] == params[:passwordconfirmation]) && (params[:password].present?)
	  	response = HTTParty.post(
		  "http://recruiting-api.nextcapital.com/users",
		  :body => { :email => params[:email], 
	               	 :password => params[:password]
	             }.to_json, 
		  :headers => { 'Content-Type' => 'application/json' } 
		)

		if response.message == 'Bad Request'
			redirect_to root_url
	    	flash.notice = "An error has occured, your email has already been registered!"
		else 
			body = JSON.parse(response.body)
			session[:passid] = body["id"]
			session[:passtoken] = body["api_token"]
			redirect_to user_dashboard_path
	    	flash.notice = "Thank you for registering!"
		end 
  	else 
			redirect_to user_dashboard_path
	    	flash.notice = "Your password confirmation must match the password you entered!"
  	end 
  end

  def destroy
	reset_session
    redirect_to root_url
    flash.notice = "You have signed out!"
  end
  

  def sign_in
  	response = HTTParty.post(
	  "http://recruiting-api.nextcapital.com/users/sign_in",
	  :body => { :email => params[:email], 
               	 :password => params[:password]
             }.to_json, 
	  :headers => { 'Content-Type' => 'application/json' } 
	)
  	if response.message == 'Bad Request'
		redirect_to root_url
    	flash.notice = "An error has occured, you may have to register or you have entered and incorrect email!"
	else 
		body = JSON.parse(response.body)
		session[:passid] = body["id"]
		session[:passtoken] = body["api_token"]
		redirect_to user_dashboard_path
    	flash.notice = "Welcome back!"
	end 
  end 


  private  
  
  
end