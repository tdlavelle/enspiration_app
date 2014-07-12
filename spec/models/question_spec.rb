require 'spec_helper'

describe Question do
  let(:user) { FactoryGirl.create(:user) }
  before { @question = user.questions.build(content: "Lorem ipsum?") }

  subject { @question }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  it { should respond_to(:responses) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @question.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @question.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @question.content = "a" * 141 }
    it { should_not be_valid }
  end

  describe "response associations" do
    before { @question.save }
    let!(:older_response) do
      FactoryGirl.create(:response, question: @question, created_at: 1.day.ago)
    end
    let!(:newer_response) do
      FactoryGirl.create(:response, question: @question, created_at: 1.hour.ago)
    end

    it "should have the responses in the right order" do
      expect(@question.responses.to_a).to eq [newer_response, older_response]
    end

    it "should destroy associated responses" do
      responses = @question.responses.to_a
      @question.destroy
      expect(responses).not_to be_empty
      responses.each do |response|
        expect(Response.where(id: response.id)).to be_empty
      end
    end
  end
end
