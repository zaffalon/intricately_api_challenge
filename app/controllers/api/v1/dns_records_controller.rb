module Api
  module V1
    class DnsRecordsController < ApplicationController
      before_action :validate_page_params, only: [:index]

      # GET /dns_records
      def index
        @dns_records = DnsRecord.filter_by_params(params).paginate(page: params[:page], per_page: 10)

        @related_hostnames = Hostname.filter_and_count(params, @dns_records.ids.uniq)

        render json: DnsRecordIndexSerializer.new(@dns_records, @related_hostnames).to_json
      end

      # POST /dns_records
      def create
        @dns_record = DnsRecord.new(dns_record_params)
        if @dns_record.save
          render json: DnsRecordSerializer.new(@dns_record).to_json
        else
          render json: ErrorSerializer.serialize(@dns_record), status: :unprocessable_entity
        end
      end

      private 

      def dns_record_params
        params.require(:dns_records).permit(
          :ip,
          hostnames_attributes: %i[hostname])
      end

      def validate_page_params
        return render json: {errors: [{field: "page", message: "params page must exist"}]}, status: :unprocessable_entity unless params[:page]
      end
    end
  end
end
