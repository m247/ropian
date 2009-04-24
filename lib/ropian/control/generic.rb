module Ropian
  module Control
    class Generic
      States = [:on, :off, :reboot]
      def inspect
        "#<#{self.class} #{@manager.host}@#{@manager.community}>"
      end
      def initialize(ip_addr, community, version = :SNMPv2c)
        @manager = SNMP::Manager.new(:Host => ip_addr,
          :Community => community, :Version => version)
      end
      def turn_on(port_index)
        set_state(:on, port_index)
      end
      def turn_off(port_index)
        set_state(:off, port_index)
      end
      def reboot(port_index)
        set_state(:reboot, port_index)
      end
      def set_state(state, port_index)
        raise ArgumentError, "invalid state" unless States.include?(state)
        @manager.set(SNMP::VarBind.new(base_oid + port_index,
                                        SNMP::Integer.new(state_order.index(state))))
      end
      protected
        def base_oid
          raise NotImplementedError, "method must be overridden"
        end
        def state_order
          States
        end
    end
  end
end
