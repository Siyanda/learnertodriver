require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(name: "Siyanda Maphumulo",
                        first_name: "Siyanda",
                        last_name: "Maphumulo",
                        username: "maphumulops",
                        email: "siyanda@mail.com")
  }

  it "is not valid without a email address" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
end