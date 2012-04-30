module Ropian
  module Meter
    # Generic base class for vendor specific subclasses.
    #
    # Provides the common API which subclasses will adhere to.
    class Generic
      # Provides inspection details for the current receiver.
      #
      # @return [String] inspection string
      # @private
      def inspect
        "#<#{self.class} #{@manager.host}@#{@manager.community}>"
      end

      # Creates and returns a new instance of Ropian::Meter::Generic.
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

      # Collects and yields the unit current and outlet currents to the given block
      #
      # @yield [total_amps, outlet_amps]
      # @yieldparam [Float] total_amps Total unit current in Amps
      # @yieldparam [Hash<Integer,Float>] outlet_amps Hash of the power outlet Amps, may be empty if unsupported
      def collect
        yield total_amps, all_outlet_amps
      end

      # Returns the total number of amps for the receiver
      # @return [Float] total current usage of the receiver in amps
      def total_amps
        amps_for_oid(unit_current_oid)
      end

      # Returns the current of the given +outlet+ in amps.
      # @param [#to_i] outlet Outlet number
      # @return [Float] outlet current usage in amps.
      def outlet_amps(outlet)
        amps_for_oid(outlet_current_base_oid + outlet.to_i)
      end

      protected
        # If the vendor returns current in values in milli-amps for example
        # this method can be overridden to return 1000.
        #
        # @return [Numeric] Amps scaling factor.
        def amps_scale_factor
          1
        end

        # @param [SNMP::ObjectId] oid
        # @return [Float] number of Amps for specified +oid+.
        def amps_for_oid(oid)
          @manager.get(oid).varbind_list.first.value.to_f / amps_scale_factor
        end

        # @return [SNMP::ObjectId] SNMP OID where the unit current can be retrieved
        def unit_current_oid
          raise NotImplementedError, "must be overridden by subclasses"
        end

        # @return [SNMP::ObjectId] Base SNMP OID where the outlet current can be retrieved
        def outlet_current_base_oid
          raise NotImplementedError, "must be overridden by subclasses"
        end

        # Returns a hash of the current for each outlet in amps.
        # @return [Hash<Integer,Float>] Hash of the outlet numbers and their current in amps.
        def all_outlet_amps
          results = {}

          begin
            @manager.walk(outlet_current_base_oid) do |r|
              r.each do |varbind|
                results[varbind.name.index(outlet_current_base_oid)] = varbind.value.to_f / amps_scale_factor
              end
            end
          rescue NotImplementedError
            # catch from outlet_current_base_oid if not supported in subclass
            # we don't interfere with the results and return the empty hash.
          end

          results
        end
    end
  end
end
