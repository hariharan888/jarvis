require "rails_helper"

RSpec.describe NotificationChannel, type: :channel do
  let(:user) { create(:user) }

  before do
    stub_connection current_user: user
  end

  describe "#subscribed" do
    it "subscribes to a stream for the current user" do
      subscribe
      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_for(user)
    end

    it "logs subscription" do
      expect(Rails.logger).to receive(:debug).with("User #{user.id} subscribed to NotificationChannel")
      subscribe
    end
  end

  describe "#unsubscribed" do
    it "logs unsubscription" do
      subscribe
      expect(Rails.logger).to receive(:debug).with("User #{user.id} unsubscribed to NotificationChannel")
      subscription.unsubscribe_from_channel
    end
  end

  describe "#receive" do
    it "logs received data" do
      subscribe
      data = { message: "Hello" }
      expect(Rails.logger).to receive(:debug).with("Received data: #{data.inspect} from User #{user.id}")
      perform :receive, data
    end
  end

  describe "#broadcast" do
    it "logs and broadcasts data" do
      subscribe
      data = { message: "Hello" }
      expect(Rails.logger).to receive(:debug).with("Broadcasting NotificationChannel data: #{data.inspect} to User #{user.id}")
      expect(NotificationChannel).to receive(:broadcast_to).with(user, data)
      perform :broadcast, data
    end
  end
end
