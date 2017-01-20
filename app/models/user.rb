require 'bcrypt'
require 'json'
require 'httparty'

class User < ActiveRecord::Base

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_secure_password


  def self.newyorktimes(page_number)
    url = ENV["API_NYTIMES"] + '?api-key=' + ENV["API_KEY_NYT"]

    query_params = "&fq=document_type:(\"recipe\")" + '&page=' + page_number

    response = HTTParty.get(url + query_params)
    @result = JSON.parse(response.body)
    @result
  end

end
