require 'rails_helper'

RSpec.describe OrderStateMachine, type: :model do
  let(:order_new)         { create(:order) }
  let(:order_confirmed)   { create(:order, :confirmed) }
  let(:order_paid)        { create(:order, :paid) }
  let(:order_in_progress) { create(:order, :in_progress) }
  let(:order_shipped)     { create(:order, :shipped) }

  describe "guards" do
    it "can transition from state new to state cancelled" do
      expect { order_new.transition_to!(:cancelled) }.to_not raise_error
    end

    it "can transition from state new to state confirmed" do
      expect { order_new.transition_to!(:confirmed) }.to_not raise_error
    end

    it "can transition from state confirmed to state cancelled" do
      expect { order_confirmed.transition_to!(:cancelled) }.to_not raise_error
    end

    it "can transition from state confirmed to state paid" do
      expect { order_confirmed.transition_to!(:paid) }.to_not raise_error
    end

    it "can transition from state paid to state cancelled" do
      expect { order_paid.transition_to!(:cancelled) }.to_not raise_error
    end

    it "can transition from state paid to state in progress" do
      expect { order_paid.transition_to!(:in_progress) }.to_not raise_error
    end

    it "can transition from state in progress to state cancelled" do
      expect { order_in_progress.transition_to!(:cancelled) }.to_not raise_error
    end

    it "can transition from state in progress to state shipped" do
      expect { order_in_progress.transition_to!(:shipped) }.to_not raise_error
    end

    it "can transition from state in shipped to state cancelled" do
      expect { order_shipped.transition_to!(:cancelled) }.to_not raise_error
    end
  end

  describe "after transition" do
    context 'to confirmed' do
      it "sends an email" do
        expect { order_new.transition_to!(:confirmed) }.
          to change { ActionMailer::Base.deliveries.count }.
          by(1)
      end
    end

    context 'to paid' do
      it "sends an email" do
        expect { order_confirmed.transition_to!(:paid) }.
          to change { ActionMailer::Base.deliveries.count }.
          by(2)
      end
    end

    context 'to in progress' do
      it "sends an email" do
        expect { order_paid.transition_to!(:in_progress) }.
          to change { ActionMailer::Base.deliveries.count }.
          by(3)
      end
    end

    context 'to shipped' do
      it "sends an email" do
        expect { order_in_progress.transition_to!(:shipped) }.
          to change { ActionMailer::Base.deliveries.count }.
          by(4)
      end
    end

    context 'to cancelled' do
      it "sends an email" do
        expect { order_new.transition_to!(:cancelled) }.
          to change { ActionMailer::Base.deliveries.count }.
          by(1)
      end
    end
  end
end
