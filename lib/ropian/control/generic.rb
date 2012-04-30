module Ropian
  module Control
    # Generic base class for vendor specific subclasses.
    #
    # Provides the common API which subclasses will adhere to.
    class Generic

      # Symbols for the types of supported power states which can
      # be set on power device sockets.
      States = [:on, :off, :reboot]

      # Provides inspection details for the current receiver.
      #
      # @return [String] inspection string
      # @private
      def inspect
        "#<#{self.class} #{@manager.host}@#{@manager.community}>"
      end

      # Creates and returns a new instance of a Ropian::Control::Generic class.
      #
      # @param [String] ip_addr The IP address of the power device.
      # @param [String] community The SNMP write community string to
      #                 be used when communicating with the device.
      # @param [Symbol] version The SNMP version symbol specifying the
      #                 version of SNMP to use when communicating with the device.
      def initialize(ip_addr, community, version = :SNMPv2c)
        @manager = SNMP::Manager.new(:Host => ip_addr,
          :Community => community, :Version => version)
      end

      # Sets the power state of the specified port(s) to ON
      #
      # @param [#to_i, Array] port_index Port index or array of indexes to turn ON.
      # @return [Boolean] success or failure of setting the ports to on.
      def turn_on(port_index)
        set_state(:on, port_index)
      end

      # Sets the power state of the specified port(s) to OFF
      #
      # @param [#to_i, Array] port_index Port index or array of indexes to turn OFF
      # @return [Boolean] success or failure of setting the ports to off.
      def turn_off(port_index)
        set_state(:off, port_index)
      end

      # Power cycles the specified port(s) turning them OFF then ON.
      #
      # The delay between the OFF and the ON is usually configured on the
      # device itself, it is usually in the region of 10 seconds.
      #
      # @param [#to_i, Array] port_index Port index or array of indexes to power cycle.
      # @return [Boolean] success or failure of setting the ports to reboot.
      def reboot(port_index)
        set_state(:reboot, port_index)
      end

      # Sets the given +state+ on the specified port(s).
      #
      # @param [Symbol] state The state to set the ports to.
      # @param [#to_i, Array] port_index Port index or array of indexes to set the state on.
      # @return [Boolean] success or failure of setting the specified +state+.
      # @raise [ArgumentError] if the provided +state+ is not a member of States.
      # @see States
      def set_state(state, port_index)
        raise ArgumentError, "invalid state" unless States.include?(state)

        varbindings = Array(port_index).map do |index|
          SNMP::VarBind.new(base_oid + index,
            SNMP::Integer.new(state_order.index(state)))
        end

        response = @manager.set(varbindings)
        response.error_index == 0 # no error
      end

      protected
        # @return [SNMP::ObjectId] SNMP Base OID for power control
        def base_oid
          raise NotImplementedError, "method must be overridden"
        end
        # @return [Array] Array mapping the States to the corresponding SNMP integer value to set.
        def state_order
          States
        end
    end
  end
end
