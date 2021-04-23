module Api
  module V1
    class DnsRecordsController < ApplicationController
      before_action :validate_page_params, only: [:index]

      # GET /dns_records
      def index
        @dns_records = DnsQuery.filter(params).paginate(page: params[:page], per_page: 100)

        @related_hostnames = RelatedHostname.filter(@dns_records, params)
      end

      # POST /dns_records
      def create
        @dns_record = DnsRecord.new(dns_record_params)
        if @dns_record.save
          render status: :created
        else
          render json: @dns_record.errors, status: :unprocessable_entity
        end
      end

      private 

      def dns_record_params
        params.require(:dns_records).permit(
          :ip,
          hostnames_attributes: %i[hostname])
      end

      def validate_page_params
        return render json: {"page": ["params page must exist"]}, status: :bad_request unless params[:page]
      end
    end
  end
end
