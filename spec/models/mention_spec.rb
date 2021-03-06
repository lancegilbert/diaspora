#   Copyright (c) 2010-2011, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

require "spec_helper"

describe Mention, type: :model do
  describe "after destroy" do
    it "destroys a notification" do
      sm = alice.post(:status_message, text: "hi", to: alice.aspects.first)
      mention = Mention.create!(person: bob.person, post: sm)

      Notifications::Mentioned.notify(sm, [bob.id])

      expect {
        mention.destroy
      }.to change(Notification, :count).by(-1)
    end
  end
end
