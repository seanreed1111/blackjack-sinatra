class YamlCard

  attr_accessor :suit, :value, :rank, :filename
  def initialize(data)
    data.keys.each do |key|
       self.instance_variable_set(:"@#{key}", data[key])
       self.class.send(:attr_reader, :"#{key}")
     end
  end

  def is_ace?
    @rank == "A"
  end
end