class Payout < ActiveRecord::Base

  belongs_to :corp
  has_many :ops

  def total_claims
    corp.ops.where(payout_id: nil).reduce(0) do |total, op|
      total + op.total
    end
  end

  def dividend_matrix
    matrix = []
    one_claim = amount_payable * 0.8 / total_claims

    corp.ops.where(payout_id: nil).each do |op|
      op.participants.each do |participant|
        existing = matrix.find{ |item| item[:name] == participant.name }
        if existing
          existing[:total] += (participant.value * one_claim)
        else
          matrix << { name: participant.name, total: (participant.value * one_claim) }
        end
      end
    end

    matrix
  end
end
