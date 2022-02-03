# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
    validates :cat_id,:start_date,:end_date,:status, presence: true
    validates :status, inclusion: %w('APPROVED' 'PENDING' 'DENIED')
    validate :does_not_overlap_approved_request
    belongs_to :cat

    after_initialize :set_pending


    private
    def set_pending
        self.status ||='PENDING'
    end
    
    def overlapping_requests
        CatRentalRequest.where.not(id: self.id).where(cat_id: self.cat.id)
        .where.not('start_data > ? OR end_date < ?',self.end_date,self.start_date)
    end
    def overlapping_approved_requests
        overlapping_requests.where(status: 'APPROVED')
    end

    def does_not_overlap_approved_request
        unless overlapping_approved_requests.empty?
            errors[:base] << "Cannot overlap an existing appointment."
    end
end
