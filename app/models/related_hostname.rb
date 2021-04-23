class RelatedHostname

    def self.filter(dns_records, params)
        scoped = Hostname.select("DISTINCT hostnames.hostname, count(hostnames.dns_record_id) as count")
        .joins(:dns_record)
        .group("hostnames.hostname")
        .where("dns_record_id in (:dns_record_ids)", dns_record_ids: dns_records.map(&:id))
    
        if params[:included]
            scoped = scoped
            .where("hostname not in (:included)", included: params[:included] )
        end

        if params[:excluded]
            scoped = scoped
            .where("hostname not in (:excluded)", excluded: params[:excluded] )
        end
    
        scoped
    end
    
end