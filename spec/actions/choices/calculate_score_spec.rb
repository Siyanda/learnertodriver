# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Choices::CalculateScore, type: :action do
  subject { described_class.execute(ctx) }

  let(:ctx) do
    {
      evaluation: nil,
    }
  end

  context "when executed" do
    xit "is expected to be successful" do
      expect(subject).to be_a_success
    end
  end
end
