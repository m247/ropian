module Ropian
  module Control
    class Raritan < Generic
      def base_oid
        @base_oid ||= SNMP::ObjectId.new('1.3.6.1.4.1.13742.4.1.2.2.1.3')
      end
      def state_order
        @state_order ||= [:off, :on, :reboot]
      end
    end
  end
end
