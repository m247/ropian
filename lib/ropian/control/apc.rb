module Ropian
  module Control
    # This class provides support for APC brand power devices.
    class APC < Generic
      protected
        # @return [SNMP::ObjectId] the SNMP base OID for power control
        def base_oid
          @base_oid ||= SNMP::ObjectId.new('1.3.6.1.4.1.318.1.1.12.3.3.1.1.4')
        end

        # APC power devices map the on, off and reboot states to 1, 2, and 3.
        #
        # @return [Array] array to map the states to the SNMP integer values.
        def state_order
          @state_order ||= [nil, :on, :off, :reboot]
        end
    end
  end
end
