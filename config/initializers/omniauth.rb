Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "1635328966746200", "dec28ac23a4980c3e2a774f50af6a6a2", { scope: 'email, public_profile, user_birthday, user_location, user_about_me', info_fields: 'email,name,gender,birthday,location,bio'}
end

