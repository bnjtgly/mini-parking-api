# frozen_string_literal: true

module Services
  module CalculationService

    def calculate_fee(hours, slot_fee)
      if hours < 24
        regular_rate(hours, slot_fee)
      else
        full_rate(hours, slot_fee)
      end
    end

    def regular_rate(hours, slot_fee)
      flat_rate_time = 3
      flat_rate_fee = 40

      return (hours - flat_rate_time) * slot_fee if hours > flat_rate_time

      flat_rate_fee
    end

    def full_rate(hours, slot_fee)
      full_day = 24
      full_day_rate = 5000
      total_hours = hours.divmod full_day

      (total_hours.first * full_day_rate) + (total_hours.last * slot_fee)
    end
  end

end