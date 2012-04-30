require 'snmp'

# Extension to provides read access to :host, :community and :version
# instance variables.
#
# We've done this primarily for #inspect cases.
#
# @private
class SNMP::Manager
  attr_reader :host, :community, :version
end

# Extension to provides additive properties to SNMP::ObjectId instances.
#
# @private
class SNMP::ObjectId
  # Adds the provided suboid or array of suboids to the
  # receiver an returns a new instance.
  #
  # @param [#to_i,Array] suboid or array of suboids to append to the receiver.
  # @return [SNMP::ObjectId] new OID with the +val+ appended to the receivers suboids.
  def +(val)
    current = self.to_a
    val = [val.to_i] unless val.kind_of?(Array)
    return self.class.new(current + val)
  end
end

# Ropian is a collection of modules and classes for working with SNMP power devices.
module Ropian
  # The control module classes provide functionality for managing the power state of
  # sockets on the power devices. Turning sockets on, off or rebooting for example.
  module Control
    autoload :Generic,  File.expand_path('../ropian/control/generic', __FILE__)
    autoload :APC,      File.expand_path('../ropian/control/apc', __FILE__)
    autoload :Raritan,  File.expand_path('../ropian/control/raritan', __FILE__)
  end

  # The meter module classes provide functionality for collecting power usage information
  # from power devices. They support per socket power usage stats where hardware support is present.
  module Meter
    autoload :Generic,  File.expand_path('../ropian/meter/generic', __FILE__)
    autoload :APC,      File.expand_path('../ropian/meter/apc', __FILE__)
    autoload :Raritan,  File.expand_path('../ropian/meter/raritan', __FILE__)
  end
end
