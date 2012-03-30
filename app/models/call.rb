class Call
  include Mongoid::Document
  include Halloped::AutoFormatLocalizedAttributes
  include Mongoid::Timestamps

  belongs_to :organ

  field :title, type: String
  field :member_amount, type: Integer
  field :deputy_amount, type: Integer
  field :quota_information, type: String
  field :date_open, type: Date
  field :date_start, type: Date
  field :date_end, type: Date
  field :term_start, type: Date
  field :term_end, type: Date
  field :appointment_place_and_date, type: String
  field :description, type: String

  def formatted_term
    if term_start and term_end
      I18n.l(term_start) + ' - ' + I18n.l(term_end)
    else
      ''
    end
  end

  def formatted_submission_dates
    if date_start and date_end
      I18n.l(date_start) + ' - ' + I18n.l(date_end)
    else
      ''
    end
  end

end
