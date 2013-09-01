class UserMailer < ActionMailer::Base
	#for things that are common to all emails
  default from: 'blogospheremagazine.com'

  def welcome_email
  	#add email as an argument here so that can put it in the :to address field
  	attachments["BlogosphereMagazine.pdf"] = File.read("#{Rails.root}/non-public/BlogosphereMagazine.pdf")
  	mail :subject => "Mandrill rides the Rails!",
  	     :to => "mathildathompson288@gmail.com",
  	     :from => "editorial@blogospheremagazine.com"
  	# mail(to: @user.email, subject:"Welcome to my Awesome site")
  end
end