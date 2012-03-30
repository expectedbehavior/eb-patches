#
# ActiveSupport patches
#
module ActiveSupport
  # Format the buffered logger with timestamp/severity info.
  class BufferedLogger
    NUMBER_TO_NAME_MAP  = {0=>'DEBUG', 1=>'INFO', 2=>'WARN', 3=>'ERROR', 4=>'FATAL', 5=>'UNKNOWN'}
    NUMBER_TO_COLOR_MAP = {0=>'0;37', 1=>'32', 2=>'33', 3=>'31', 4=>'31', 5=>'37'}

    def add(severity, message = nil, progname = nil, &block)
      return if @level > severity
      sevstring = NUMBER_TO_NAME_MAP[severity]
      color     = NUMBER_TO_COLOR_MAP[severity]

      message = (message || (block && block.call) || progname).to_s
      time_format = "%Y%m%d-%T"
      # pid = "%6d" % $$
      message.split("\n").each do |part|
        part = "\033[0;37m#{Time.now.utc.strftime(time_format)}\033[0m [\033[#{color}m" + sprintf("%5s","#{sevstring}") + "\033[0m] #{part}\n" unless message[-1] == ?\n
        # puts part.inspect
        buffer << part
      end
      # message = "\033[#{color}m#{message}\033[0m\n"
      # buffer << message
      auto_flush
      message
    end
  end
end
