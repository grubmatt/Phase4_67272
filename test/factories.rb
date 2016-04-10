FactoryGirl.define do
  factory :store do
    name "CMU"
    street "5000 Forbes Avenue"
    city "Pittsburgh"
    state "PA"
    zip "15213"
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    active true
  end
  
  factory :employee do
    first_name "Ed"
    last_name "Gruberman"
    ssn { rand(9 ** 9).to_s.rjust(9,'0') }
    date_of_birth 19.years.ago.to_date
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    role "employee"
    active true
  end
  
  factory :assignment do
    association :store
    association :employee
    start_date 1.year.ago.to_date
    end_date 1.month.ago.to_date
    pay_level 1
  end

  factory :shift do
    date Date.current
    assignment_id 1
    start_time Date.current + 2.hours
    notes "Nothing Special"
  end

  factory :job do
    name "Cashier"
    description "Worked at the register to handle transactions"
    active 1
  end

  factory :shift_job do
    shift_id 1
  end

  factory :flavor do
    name "Chocolate"
    active 1
  end

  factory :user do
    employee_id 1
    email "gruberman@example.com"
    password_digest "secret"
  end

end
