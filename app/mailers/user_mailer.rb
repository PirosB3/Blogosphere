class UserMailer < ActionMailer::Base
	#for things that are common to all emails
  default from: 'blogospheremagazine.com'

  def welcome_email
  	attachments["ShoreditchHouse.pdf"] = File.read("#{Rails.root}/non-public/ShoreditchHouse.pdf")
  	mail :subject => "Mandrill rides the Rails!",
  	     :to => "mathildathompson288@gmail.com",
  	     :from => "editorial@blogospheremagazine.com"
  	# mail(to: @user.email, subject:"Welcome to my Awesome site")
  end
end