require 'spec_helper'

describe Ghee::Connection do
  context "with an access_token" do
    subject { Ghee::Connection.new(ACCESS_TOKEN) }

    describe "#initialize" do
      it "should set an instance variable for access token" do
        subject.access_token.should == ACCESS_TOKEN
      end
    end

    describe "any request" do
      let(:response) do
        VCR.use_cassette('authorized_request') do
          subject.get('/')
        end
      end

      it "should return 204" do
        response.status.should == 204
      end

      it "should parse the json response" do
        response.body.should == ""
      end
    end
  end

  context "without an access token" do
    subject { Ghee::Connection.new }

    describe "#initialize" do
      it "should set an instance variable for access token" do
        subject.access_token.should == nil
      end
    end

    describe "any request" do
      let(:response) do
        VCR.use_cassette('unauthorized_request') do
          subject.get('/')
        end
      end
      it "should return 204" do
        response.status.should == 204
      end

      it "should parse the json response" do
        response.body.should == ""
      end
    end
  end
end