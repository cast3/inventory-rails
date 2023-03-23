class User < ApplicationRecord
  include Signupable
  include Onboardable
end
