require "spec_helper"

describe Yard4Apis::Documentation do
  
  describe "supporting namespaces" do
    before(:all) do
      @services = Yard4Apis::Services.new({:namespace => "api", :url_prefix => "api/v1", :reload => true})
      @doc = @services.documentation("statuses/update")
      @doc2 = @services.documentation("friendships/check")
    end

    describe "documentation" do
      it "should expose the description from the inline controller documentation" do
        @doc.description.should == "Update the user's weplay status"
      end

      it "should expose the http method from the route" do
        @doc.http_method.should == "POST"
      end

      it "should expose the service_name" do
        @doc.service_name.should == "statuses/update"
      end

      it "should expose the full url" do
        @doc.url.should == "/api/v1/statuses/update"
      end

      it "should expose the formats" do
        @doc.formats.should == ['xml', 'json']
      end

      it "should reflect whether authentication is required" do
        @doc.authenticated.should == true
        @doc2.authenticated.should == false
      end

      it "should expose the parameter tags" do
        @doc.parameters.size.should == 1
        ptag = @doc.parameters.first
        ptag.required.should be
        ptag.description.should == "Your weplay status"
        ptag.parameter.should == "status"
      end

      it "should expose the returns tag value" do
        @doc.returns.should == nil
        @doc2.returns.should == "Set of friend_ids and pending_ids which represent friends of the target member and friends the target member has requested"
      end
    end
    
    describe "all" do
      it "should should have two services" do
        @services.all.size.should == 2
      end
      
      it "should contain both services" do
        @services.all[0].service_name.should == 'friendships/check'
        @services.all[1].service_name.should == 'statuses/update'
      end
    end
    
  end
  
  describe "without namespaces" do
    before(:all) do
      services = Yard4Apis::Services.new({:reload => true})
      @doc = services.documentation("groups")
    end

    it "should expose the inline controller documentation" do
      @doc.description.should == "Retrieve a list of groups for a user"
    end

    it "should expose the http method from the route" do
      @doc.http_method.should == "GET"
    end

    it "should expose the service_name" do
      @doc.service_name.should == "groups"
    end

    it "should expose the full url" do
      @doc.url.should == "/groups"
    end

    it "should expose the formats" do
      @doc.formats.should == ['xml', 'json']
    end

    it "should reflect whether authentication is required" do
      @doc.authenticated.should == false
    end

    it "should expose the parameter tags" do
      @doc.parameters.size.should == 1
      ptag = @doc.parameters.first
      ptag.required.should be
      ptag.description.should == "The user to retrieve groups for"
      ptag.parameter.should == "user_id"
    end

    it "should expose the returns tag value" do
      @doc.returns.should == "A list of groups for the specified user"
    end
  end

end