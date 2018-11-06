# telstra_messaging_api
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module TelstraMessagingApi
  # Poll for incoming messages returning the latest. Only works if no callback
  # url was specified when provisioning a number.
  class InboundPollResponse < BaseModel
    # message status
    # @return [String]
    attr_accessor :status

    # The phone number (recipient) that the message was sent to (in E.164
    # format).
    # @return [String]
    attr_accessor :destination_address

    # The phone number (sender) that the message was sent from (in E.164
    # format).
    # @return [String]
    attr_accessor :sender_address

    # Text of the message that was sent
    # @return [String]
    attr_accessor :message

    # Message Id
    # @return [String]
    attr_accessor :message_id

    # The date and time when the message was sent by recipient.
    # @return [String]
    attr_accessor :sent_timestamp

    # A mapping from model property names to API property names.
    def self.names
      @_hash = {} if @_hash.nil?
      @_hash['status'] = 'status'
      @_hash['destination_address'] = 'destinationAddress'
      @_hash['sender_address'] = 'senderAddress'
      @_hash['message'] = 'message'
      @_hash['message_id'] = 'messageId'
      @_hash['sent_timestamp'] = 'sentTimestamp'
      @_hash
    end

    def initialize(status = nil,
                   destination_address = nil,
                   sender_address = nil,
                   message = nil,
                   message_id = nil,
                   sent_timestamp = nil)
      @status = status
      @destination_address = destination_address
      @sender_address = sender_address
      @message = message
      @message_id = message_id
      @sent_timestamp = sent_timestamp
    end

    # Creates an instance of the object from a hash.
    def self.from_hash(hash)
      return nil unless hash

      # Extract variables from the hash.
      status = hash['status']
      destination_address = hash['destinationAddress']
      sender_address = hash['senderAddress']
      message = hash['message']
      message_id = hash['messageId']
      sent_timestamp = hash['sentTimestamp']

      # Create object from extracted values.
      InboundPollResponse.new(status,
                              destination_address,
                              sender_address,
                              message,
                              message_id,
                              sent_timestamp)
    end
  end
end
