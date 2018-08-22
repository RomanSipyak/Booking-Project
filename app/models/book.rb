class Book < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validate :start_gt_current_time, :start_lt_end
  extend ItemSplitter

  split(title)

  def start_lt_end
    if start_booking > end_booking
      errors.add(:start_booking, 'bed: start > end')
    end
  end

  def start_gt_current_time
    if start_booking < DateTime.current
      errors.add(:start_booking, 'bed: start < current time')
    end
  end
end
