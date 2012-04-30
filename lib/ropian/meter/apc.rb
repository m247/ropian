module Ropian
  module Meter
    # This class provides support for APC brand power devices.
    class APC < Generic
      protected
        # If the vendor returns current in values in milli-amps for example
        # this method can be overridden to return 1000.
        #
        # @return [Numeric] Amps scaling factor.
        def amps_scale_factor
          10
        end

        # @return [SNMP::ObjectId] SNMP OID where the unit current can be retrieved
        def unit_current_oid
          @unit_current_oid ||= SNMP::ObjectId.new('1.3.6.1.4.1.318.1.1.12.2.3.1.1.2.1')
        end
    end
  end
end
