module Ropian
  module Control
    # This class provides support for Raritan brand power devices.
    class Raritan < Generic
      protected
        # @return [SNMP::ObjectId] the SNMP base OID for power control
        def base_oid
          @base_oid ||= SNMP::ObjectId.new('1.3.6.1.4.1.13742.4.1.2.2.1.3')
        end

        # Raritan power devices map the on, off and reboot states to 1, 0, and 2.
        #
        # @return [Array] array to map the states to the SNMP integer values.
        def state_order
          @state_order ||= [:off, :on, :reboot]
        end
    end
  end
end
