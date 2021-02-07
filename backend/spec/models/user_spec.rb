# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)      not null
#  name            :string(255)
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require "rails_helper"

RSpec.describe User do
  fixtures :users

  describe "authenticate" do
    let(:target) { proc { |e, p| described_class.authenticate(e, p) } }
    let(:user1_email) { "one@example.com" }
    let(:user1_pass) { "Password0" }

    it do
      actual = target.call(user1_email, user1_pass)
      expect(actual.email).to eq(user1_email)
    end

    it do
      actual = target.call("#{user1_email}some_other_chars", user1_pass)
      expect(actual).to be_falsey
    end

    it do
      actual = target.call(user1_email, "#{user1_pass}some_other_chars")
      expect(actual).to be_falsey
    end
  end
end
