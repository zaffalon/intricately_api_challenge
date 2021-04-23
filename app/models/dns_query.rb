class DnsQuery

    def self.filter(params)
        scoped = DnsRecord.from(DnsRecord
            .select("dns_records.*, array_agg(hostnames.hostname)::text[] array_of_hostnames")
            .joins(:hostnames)
            .group("dns_records.id"), :dns_records)
    
        if params[:included]
            scoped = scoped.where('array_of_hostnames @> ARRAY[:included]', included: params[:included])
        end
    
        if params[:excluded]
            scoped = scoped.where.not('array_of_hostnames @> ARRAY[:excluded]', excluded: params[:excluded])
        end
    
        scoped
    end
    
end
