ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 25, # ports 587 and 2525 are also supported with STARTTLS
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => "mathildathompson288@gmail.com",
    :password  => "saPSbRNyBKfrzdEE5c0DAw", # SMTP password is any valid API key
    :authentication => 'login', # Mandrill supports 'plain' or 'login'
    :domain => 'blogospheremagazine.com', # your domain to identify your server when connecting
  }

#setup yaml config file to change the default url depending on the environment
ActionMailer::Base.default_url_options[:host] = "localhost:3000"