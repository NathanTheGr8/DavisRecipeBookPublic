class Recipe < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	
	has_attached_file :picture, :styles => { 
			:xl => "1066x600#",
			:lg => "711x400#",
			:md => "300x300#",
			:sm => "200x200#",
			:thumb => "100x100#" 
		}, 
		:default_url => "recipe/:style/1.jpg",
		:bucket =>'davisrecipebook',
		:storage => :s3,
		:s3_credentials => "#{Rails.root}/config/s3.yml"
		
        #:s3_credentials => Proc.new{|a| a.instance.s3_credentials }
        #:storage => :dropbox,
    	#:dropbox_credentials => Rails.root.join("config/dropbox.yml")

  #def s3_credentials
  #  {:bucket =>'davisrecipebook', :access_key_id => '', :secret_access_key => ''}
  #end
		
	
  	validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  	validates_attachment_size :picture, :less_than => 40.megabytes

  	
end
