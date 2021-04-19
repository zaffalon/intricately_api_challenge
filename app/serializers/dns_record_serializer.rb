# frozen_string_literal: true

class DnsRecordSerializer
    attr_accessor :id
    
    def initialize(dns_record)
        @id = dns_record.id
    end
end