module ClientManager
  class Client < ApplicationRecord
    belongs_to :user
  end
end
