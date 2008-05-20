require File.dirname(__FILE__) + '/../spec_helper'

describe DeliverablesController do

  #Delete this example and add some real ones
  it "should use DeliverablesController" do
    controller.should be_an_instance_of(DeliverablesController)
  end

end

describe DeliverablesController,"#index when logged in" do
  before(:each) do
    @project = mock_model(Project)
    Deliverable.stub!(:find_all_by_project_id).and_return([])
    Project.should_receive(:find).with(@project.to_param).and_return(@project)
    controller.stub!(:authorize).and_return(true)
  end
  
  it "should be successful" do
    get :index, :id => @project.id
    response.should be_success
  end
  
  it "should set @deliverables for the view" do
    get :index, :id => @project.id
    assigns[:deliverables].should_not be_nil
  end
  
  it "should only show the deliverables for the current project only" do
    Deliverable.should_receive(:find_all_by_project_id).with(@project.id)
    get :index, :id => @project.id
  end
end
