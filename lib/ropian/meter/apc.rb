module Ropian
  module Meter
    class APC < Generic
      UnitCurrent = SNMP::ObjectId.new('1.3.6.1.4.1.318.1.1.12.2.3.1.1.2.1')

      def collect # :yields: total_amps, hash_of_outlet_amps
        yield total_amps, {}
      end
      # Amps in total on whole bar
      def total_amps
        amps_for_oid(UnitCurrent)
      end
      def outlet_amps(outlet_index)
        raise NotImplementedError, "APC Power Bars do not support per outlet power stats"
      end
      protected
        def amps_for_oid(oid)
          @manager.get(oid).varbind_list.first.value.to_f / 10
        end
    end
  end
end
