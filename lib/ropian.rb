require 'snmp'

require 'ropian/control/generic'
require 'ropian/control/raritan'
require 'ropian/control/apc'

require 'ropian/meter/generic'
require 'ropian/meter/raritan'
require 'ropian/meter/apc'

# :stopdoc:
class SNMP::Manager
  attr_reader :host, :community, :version
end
class SNMP::ObjectId
  def +(val)
    current = self.to_a
    unless val.kind_of?(Array)
      current << val.to_i
      return self.class.new(current)
    else
      return self.class.new(current + val.to_a)
    end
  end
end
# :startdoc:

module Ropian # :nodoc:
  module Control # :nodoc:
  end
  module Meter # :nodoc:
  end
end
