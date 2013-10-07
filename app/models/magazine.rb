class Magazine < ActiveRecord::Base
  attr_accessible :image_url, :issue_number, :month, :name, :price, :purchase_type, :path

  has_many :checkout_magazines
  has_many :checkouts, :through => :checkout_magazines
  
  def get_secure_url
     # Get the S3 object
     s3 = AWS::S3.new(
       :access_key_id => ENV["AWS_KEY_ID"],
       :secret_access_key => ENV["AWS_SECRET_KEY"]
     )
     
     # Get the S3 bucket
     bucket = s3.buckets[Blogosphere::Application.config.s3[:bucket_name]]
     
     # get the magazine file name
     magazine_object = bucket.objects[self.path]
     
     # create a secure url for self.path inside the bucket
     
     expiry_in_minutes = Blogosphere::Application.config.s3[:expiry_in_minutes]
     magazine_object.url_for(:get, {
         :expires => expiry_in_minutes.minutes.from_now,
         :secure => true
     }).to_s
  end
  
end
