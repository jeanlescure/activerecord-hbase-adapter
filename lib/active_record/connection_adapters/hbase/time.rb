require 'msgpack'

class Time
  def to_msgpack(packer)
    packer.pack self.to_s
  end
end