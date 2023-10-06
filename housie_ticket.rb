class HousieTicket

  def initialize
    @ticket =  Array.new(3) { Array.new(9) }
  end

  # Ticket possible combinations
  def column_with_number
    [
      [1,2,3,1,2,1,2,1,2], 
      [1,2,1,2,2,1,2,2,2]
    ].sample.shuffle.shuffle
  end

  # Get column numbers along with blank character 
  def get_col_numbers(col_arr, chr)
    if col_arr.length == 1
      [(col_arr + [chr, chr]), [chr, col_arr[0], chr], ([chr, chr] + col_arr)].sample
    elsif col_arr.length == 2
      [(col_arr + [chr]), [col_arr[0], chr, col_arr[1]], [chr] + col_arr].sample
    else
      col_arr
    end
  end

  #shuffle numbers to make 5 per row 
  def shuffle_ticket_row(row)
    return if @ticket.map{|row| row.select{|val| val.is_a?(Integer)}.length }.all?(5)
    # If row has less than 5 numbers, then get required numbers from next row
    if @ticket[row].select{|val| val.is_a?(Integer) }.length < 5
      exchange_row = (row == 0 ? 1 : (row == 1 ? 2 : 1))
      count = 5 - @ticket[row].select{|val| val.is_a?(Integer) }.length
       @ticket[row].each_with_index do |val, idx|
        if val.is_a?(String) && count >= 1
          if !@ticket[exchange_row][idx].is_a?(String)
            tmp = @ticket[row][idx]
            @ticket[row][idx] = @ticket[exchange_row][idx]
            @ticket[exchange_row][idx] = tmp
            count -= 1
          end
        end
       end
    end

    # If row has greater than 5 numbers, then push extra numbers to next row
    if @ticket[row].select{|val| val.is_a?(Integer) }.length > 5
      count = @ticket[row].select{|val| val.is_a?(Integer) }.length - 5
      exchange_row = (row == 0 ? 1 : (row == 1 ? 2 : 1))
      @ticket[row].each_with_index do |val, idx|
        if !val.is_a?(String) && count >= 1
          if @ticket[exchange_row][idx].is_a?(String)
            tmp = @ticket[row][idx]
            @ticket[row][idx] = @ticket[exchange_row][idx]
            @ticket[exchange_row][idx] = tmp
            count -= 1
          end
        end
       end
       
    end
    shuffle_ticket_row(row >=2 ? 0 : (row + 1)) # Increase row number and repeate untile make 5 numbers per row
  end


  def print
    nums = [(1..9).to_a, (10..19).to_a, (20..29).to_a, (30..39).to_a, (40..49).to_a, (50..59).to_a, (60..69).to_a, (70..79).to_a, (80..90).to_a]
    column_with_number.each_with_index do |value, key|
      col_arr = get_col_numbers(nums[key].sample(value).sort, (key == 0 ? ' ' : '  '))
      @ticket[0][key] = col_arr[0]
      @ticket[1][key] = col_arr[1]
      @ticket[2][key] = col_arr[2]
    end
    shuffle_ticket_row(0)
    puts "\n\n"
    @ticket.each_with_index do |row, key|
      if key == 0
        puts "+----+----+----+----+----+----+----+----+----+"
      end
      puts "|  " +row.join(" | ") + " |"
      puts "+----+----+----+----+----+----+----+----+----+"
    end
    puts "\n\n"
  end

  
end
#To print one card 

HousieTicket.new.print

#To print 10 cards 
# 10.times {|i|
#   HousieTicket.new.print
# }