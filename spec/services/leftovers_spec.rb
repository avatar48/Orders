require 'rails_helper'
require 'savon/mock/spec_helper'
RSpec.describe Leftovers, type: :model do
  include Savon::SpecHelper

  before(:all) {savon.mock!}
  after(:all) {savon.unmock!}

  # it 'sss' do
  #   message = { username: 'lyke', password: 'secret'}
  #   fixture = File.read('vendor/auth.xml')
  #   start_date = {:year => 2018, :month => 4, :day => 1}
  #   # savon = Leftovers.new(start_date)
  #   # expect(savon.conect).to eq fixture 
  #   savon[:get].to eq fixture
  # end

  it "works with no message and a return" do
    start_date = {:year => 2018, :month => 4, :day => 1}
    @date = Time.new(start_date[:year].to_i, start_date[:month].to_i, start_date[:day].to_i)
    fixture = File.read('vendor/auth.xml')
    message = {date: @date.strftime("%Y-%m-%d")}
    authentication_message = { :username => "luke", :password => "secret" }
    savon.expects(:get).with(message: message).returns(fixture)
  
    start_date = {:year => 2018, :month => 4, :day => 1}
     savon = Leftovers.new(start_date)
     response = savon.conect
    expect(response).to be_successful
    # expect { new_client.call(:authenticate, :message => authentication_message) }.to_not raise_error
  end
end