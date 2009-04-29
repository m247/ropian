module Ropian
  module Meter
    class Raritan
      UnitCurrent = SNMP::ObjectId.new("1.3.6.1.4.1.13742.4.1.4.2.1.3.1")
      OutletCurrent = SNMP::ObjectId.new("1.3.6.1.4.1.13742.4.1.2.2.1.4")

      def inspect
        "#<#{self.class} #{@manager.host}@#{@manager.community}>"
      end
      def initialize(ip_addr, community, version = :SNMPv2c)
        @manager = SNMP::Manager.new(:Host => ip_addr,
          :Community => community, :Version => version)
      end
      def collect # :yields: total_amps, hash_of_outlet_amps
        results = Hash.new

        @manager.walk(OutletCurrent) do |r|
          r.each do |varbind|
            results[varbind.name.index(OutletCurrent)] = varbind.value.to_f / 1000
          end
        end

        yield total_amps, results
      end
      # Amps in total on whole bar
      def total_amps
        amps_for_oid(UnitCurrent)
      end
      # Amps per outlet
      def outlet_amps(outlet_index)
        amps_for_oid(OutletCurrent + outlet_index)
      end
      protected
        def amps_for_oid(oid)
          @manager.get(oid).varbind_list.first.value.to_f / 1000
        end
    end
  end
end
