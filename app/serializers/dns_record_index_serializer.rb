class DnsRecordIndexSerializer

    attr_accessor :total_records, :records, :related_hostnames
    
    def initialize(records, related_hostnames)
        @total_records = records.count
        @records = records.map do |record|
            { id: record.id, ip_address: record.ip }
        end
    
        @related_hostnames = related_hostnames.map do |related_hostname|
            {  count: related_hostname.count, hostname: related_hostname.hostname }
        end
    end
    
end
