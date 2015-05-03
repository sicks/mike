FactoryGirl.define do
  factory :active_op, class: Op, aliases: [:op] do
    name "homesites"
    start DateTime.now
    corp
    user
  end

  factory :scheduled_op, class: Op do
    name "af roam"
    start DateTime.now + 1.weeks
    corp
    user
  end
end
