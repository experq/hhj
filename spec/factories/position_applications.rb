# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position_application do
    association :user
    position  :position_member
    association :call

    factory :kirjakerho_application do
      association :user, :factory => :eija
      association :call, :factory => :lukurinki
    end

    factory :helsinki_uni_board_application do
      association :user, :factory => :helsinki_uni_student_union_employee
      association :call, :factory => :call_for_student_council_board
    end
    custom Hash[*['degree','VTT']]
  end
end

