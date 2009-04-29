module Ropian
  module Meter
    class Generic
      def inspect
        "#<#{self.class} #{@manager.host}@#{@manager.community}>"
      end
      def initialize(ip_addr, community, version = :SNMPv2c)
        @manager = SNMP::Manager.new(:Host => ip_addr,
          :Community => community, :Version => version)
      end
      protected
        def amps_for_oid(oid)
          @manager.get(oid).varbind_list.first.value.to_f / 1000
        end
    end
  end
end
