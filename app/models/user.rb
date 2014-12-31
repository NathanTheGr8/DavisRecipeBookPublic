class User < ActiveRecord::Base
	has_many :recipes
  has_many :comments

	#attr_accessible :email, :password, :password_confirmation
  	attr_accessor :password
    #has_secure_password

  	before_save :encrypt_password
  
  	validates_confirmation_of :password, on: :create
    validates :name, presence: true, uniqueness: true, if: :password_required?
    validates :email, presence: true, uniqueness: true 
    validates :password, presence: true, length: { in: 6..20 }, on: :create


	  has_attached_file :avatar, :styles => {
        :md => "300x300#",
        :thumb => "100x100#"
      },
      #convert_options: 
      #{
      #  medium: " -gravity center -crop '300x300+0+0'",
      #  thumb: " -gravity center -crop '100x100+0+0'"
      #},
      :default_url => "avatar/:style/missing.png",
      :bucket =>'davisrecipebook',
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml"
      #:s3_credentials => Proc.new{|a| a.instance.s3_credentials }
      #:storage => :dropbox,
      #:dropbox_credentials => Rails.root.join("config/dropbox.yml")

    #def s3_credentials
    #  {:bucket =>'davisrecipebook', :access_key_id => '', :secret_access_key => ''}
    #end

	
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  	validates_attachment_size :avatar, :less_than => 10.megabytes

  	def self.authenticate(email, password)
    	user = find_by_email(email)
    	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      		user
    	else
      		nil
    	end
  	end
  
  	def encrypt_password
    	if password.present?
      		self.password_salt = BCrypt::Engine.generate_salt
      		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    	end
  	end

    private

    def password_required?
      self.changes.include? :email # just an example
    end
end
