def debug_core(debugger, title=nil)
  title = Time.now.strftime("%d/%m/%Y %H:%M:%S.%L") unless title
  titlef = "[ #{title} ]"
  chars = 80
  bg = "-" * chars
  debugger.call(paste_centered(titlef, "\n#{bg}\n"));
  result = yield(debugger)
  debugger.call(paste_centered("[ #{result.inspect[0..(chars-20)]}... ]", "\n#{bg}"));
  debugger.call(paste_centered("[ / #{title} ]", "#{bg}\n"));
  result
end

def debug_in(*args, &block)
  debug_core(lambda {|s| Rails.logger.debug(s) }, *args, &block);
end

def debug_out(*args, &block)
  debug_core(lambda {|s| puts(s) }, *args, &block);
end

def paste_centered(str, area)
  left_pad = ((area.size - str.size) / 2.0).floor
  area.sub(/^(.{#{left_pad}}).{#{str.size}}/, "\\1#{str}")
end