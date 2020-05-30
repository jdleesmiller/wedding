# frozen_string_literal: true

#
# Make a model findable only when a secure token is provided.
#
module FindableWithToken
  extend ActiveSupport::Concern

  ID_TOKEN_RX = /\A(\d+)-(\w+)\z/.freeze

  included do
    has_secure_token

    def to_param
      id ? "#{id}-#{token}" : nil
    end

    def self.find_by_id_token(id_token)
      raise ActiveRecord::RecordNotFound unless id_token =~ ID_TOKEN_RX

      id = Regexp.last_match(1)
      token = Regexp.last_match(2)

      record = find(id)
      raise ActiveRecord::RecordNotFound unless
        ActiveSupport::SecurityUtils.secure_compare(record.token, token)

      record
    end
  end
end
