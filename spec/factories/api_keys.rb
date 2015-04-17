FactoryGirl.define do
  factory :api_key do
    key_id 4300328
    vcode "gG6S0R1nyX5Sn0taPg0VjIgqWwz3JcgxSLSilHikTmHFpnb6UNDBqyPxJU4knu1y"
    user
  end

  factory :expired_api_key, class: ApiKey do
    key_id 4300329
    vcode "BqFQDA7L7Z1BlJGg5HbPtTBITOezZmB71XAWLiyD9QZhWUJNjosSjN1XREgbeBqb"
    user
  end
end

