#kata13

require 'pry'

class Counter
  attr_accessor :lines, :tests, :in_comment
  def initialize
    @lines = Array.new
    @tests = Array.new
    @in_comment = false
  end

  def open(path)
    File.open(path,'r') { |f|
      f.each_line { |line|
        @lines.push(line.strip) if count_this_line(line.strip)
      }
    }
  end

  def count_lines
    @lines.length
  end

  private
  def count_this_line(line)
    double_slash_index = line.index(/\/\//)
    start_sign_index = line.index(/\/\*\*?/)
    end_sign_index = line.index(/\*\//)

    double_slash_index ||= -1
    start_sign_index ||= -1
    end_sign_index ||= -1

    # get rod of blank line
    if line == '' then
      return false
    end

    if @in_comment then
      if end_sign_index >= 0 && (end_sign_index < line.length - 2)
        @in_comment = false
        return true
      elsif end_sign_index == line.length - 2
        @in_comment = false
        return false
      else
        return false
      end
    else
      if double_slash_index == 0 then
        return false
      elsif double_slash_index >= 0 && (double_slash_index < start_sign_index) then
        return false
      elsif start_sign_index == 0 && end_sign_index == -1
        @in_comment = true
        return false
      elsif start_sign_index >= 0 && end_sign_index == -1
        @in_comment = true
        return true
      else
        return true
      end

    end

  end
end

c = Counter.new
c.open('test.java')
c.lines
binding.pry