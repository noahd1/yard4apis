require "spec_helper"

describe ApiDocumentation do
  before(:all) do
    ApiDocumentation.regenerate_yardoc
    @doc = ApiDocumentation.new("statuses/update")
    @doc2 = ApiDocumentation.new("friendships/check")
  end

  it "should expose the description from the inline controller documentation" do
    @doc.description.should == "Update the user's weplay status"
  end

  it "should expose the http method from the route" do
    @doc.http_method.should == "POST"
  end

  it "should expose the service_name" do
    @doc.service_name.should == "statuses/update"
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