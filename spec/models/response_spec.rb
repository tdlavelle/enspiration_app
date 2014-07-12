require 'spec_helper'

describe Response do
  
  let(:question) { FactoryGirl.create(:question) }
  before { @response = question.responses.build(content: "Lorem!") }

  subject { @response }

  it { should respond_to(:content) }
  it { should respond_to(:question_id) }
  it { should respond_to(:question) }
  its(:question) { should eq question }

  it { should be_valid }

  describe "when question_id is not present" do
    before { @response.question_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @response.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @response.content = "a" * 141 }
    it { should_not be_valid }
  end
end
