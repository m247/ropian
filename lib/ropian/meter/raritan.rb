module Ropian
  module Meter
    class Raritan
      def inspect
        "#<#{self.class} #{@manager.host}@#{@manager.community}>"
      end
      def initialize(ip_addr, community, version = :SNMPv2c)
        @manager = SNMP::Manager.new(:Host => ip_addr,
          :Community => community, :Version => version)
      end
      # Amps in total on whole bar
      def total_amps
        oid = SNMP::ObjectId.new("1.3.6.1.4.1.13742.4.1.4.2.1.3.1")
        amps_for_oid(oid)
      end
      # Amps per outlet
      def outlet_amps(outlet_index)
        oid = SNMP::ObjectId.new("1.3.6.1.4.1.13742.4.1.2.2.1.4") + outlet_index
        amps_for_oid(oid)
      end
      protected
        def amps_for_oid(oid)
          @manager.get(oid).varbind_list.first.value.to_f / 1000
        end
    end
  end
end
