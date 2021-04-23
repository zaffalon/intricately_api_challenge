json.total_records @dns_records.count

json.records @dns_records do |dns_record|
  json.id dns_record.id
  json.ip_address dns_record.ip
end

json.related_hostnames @related_hostnames do |related_hostname|
  json.hostname related_hostname.hostname
  json.count related_hostname.count
end