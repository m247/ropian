module Ropian
  module Control
    class APC < Generic
      def base_oid
        @base_oid ||= SNMP::ObjectId.new('1.3.6.1.4.1.318.1.1.12.3.3.1.1.4')
      end
      def state_order
        @state_order ||= [nil, :on, :off, :reboot]
      end
    end
  end
end
