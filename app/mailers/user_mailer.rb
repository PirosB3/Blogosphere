class UserMailer < ActionMailer::Base
	#for things that are common to all emails
  default from: 'blogospheremagazine.com'

  def welcome_email(user_email, checkout_type, checkout_transaction_id)
    @checkout_type = checkout_type
    @checkout_transaction_id = checkout_transaction_id
  	#add email as an argument here so that can put it in the :to address field
  	# attachments["BlogosphereMagazine.pdf"] = File.read("#{Rails.root}/non-public/BlogosphereMagazine.pdf")
  	mail :subject => "Payment confirmation",
  	     :to => user_email,
  	     :from => "editorial@blogospheremagazine.com"
  end
end