class SimonhypController < ApplicationController
  include Math

  def index
  end

  def hypothesis
    @input_is_ok = true
    begin
      # If params[:max]=nil then Integer(nil) throws the exception too
      max = Integer(params[:max])
      @input_is_ok = false if max.negative?
    rescue TypeError, ArgumentError
      @input_is_ok = false
    end
    if !@input_is_ok
      @result = 'ОШИБКА: недопустимый ввод'
    else
      begin
        @correct = Array[]
        @count = 0
        factorial = 1
        i = 1

        max.times do
          factorial *= i
          root = cbrt(factorial).round
          if factorial == root * (root - 1) * (root + 1)
            @count += 1
            @correct.push((root - 1).to_s + '*' + root.to_s + '*' + (root + 1).to_s + '=' + i.to_s + '!')
          end
          i += 1
        end

        @result = @count == 4 ? 'Гипотеза Симона выполняется' : 'Гипотеза Симона не выполняется'
      rescue FloatDomainError
        @result = 'ОШИБКА: последнее рассчитанное значение ' + (i-1).to_s + '!' + ' дальнейшие расчёты невозможны - недостаточно памяти'
      end
    end
    respond_to do |format|
      format.json { render json: { status: @result, content: @correct } }
    end
  end
end
