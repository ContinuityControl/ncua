module NCUA
  class ArgParser
    def self.parse(opts = {})
      client = Client.new
      if opts.keys.empty?
        raise NoArgumentError, "must have a key"
      elsif opts.keys.length > 1
        raise TooManyArgumentsError, "can only take one option"
      end

      case opts.keys.first
      when :address
        client.find_credit_union_by_address(opts[:address])
      when :name
        client.find_credit_union_by_name(opts[:name])
      when :charter_number
        client.find_credit_union_by_charter_number(opts[:charter_number])
      else
        raise InvalidArgumentError, "option must be within whitelist"
      end
    end
  end
end
