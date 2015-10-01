#kata02

def chop(tar, arg)
  arg = arg.sort
  m = (arg.length+1)/2
  l = 1
  u = arg.length
  mid = arg[m-1]
  lowerBound = arg.first
  upperBound = arg.last
  begin
    if tar == lowerBound
      puts l
      break
    elsif tar == upperBound
      puts u
      break
    elsif tar > mid
      l = m
      m = (m + u + 1)/2
      lowerBound = mid
      mid = arg[m-1]
    elsif mid > tar
      u = m
      m = (l + m + 1)/2
      upperBound = mid
      mid = arg[m-1]
    else
      puts m
      break
    end
  end until (l == m or u == m)
end

chop(1, [1, 30, 400])
