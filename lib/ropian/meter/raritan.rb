module Ropian
  module Meter
    # This class provides support for Raritan brand power devices.
    class Raritan < Generic
      protected
        # If the vendor returns current in values in milli-amps for example
        # this method can be overridden to return 1000.
        #
        # @return [Numeric] Amps scaling factor.
        def amps_scale_factor
          1000
        end

        # @return [SNMP::ObjectId] SNMP OID where the unit current can be retrieved
        def unit_current_oid
          @unit_current_oid ||= SNMP::ObjectId.new("1.3.6.1.4.1.13742.4.1.4.2.1.3.1")
        end

        # @return [SNMP::ObjectId] Base SNMP OID where the outlet current can be retrieved
        def outlet_current_base_oid
          @outlet_current_base_oid ||= SNMP::ObjectId.new("1.3.6.1.4.1.13742.4.1.2.2.1.4")
        end
    end
  end
end
