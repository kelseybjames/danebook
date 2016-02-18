module Macros
  module User
    def sign_up_form(email: 'foo@bar.com',
                     password: 'foobar',
                     confirmation: 'foobar',
                     first_name: 'Foo',
                     last_name: 'Bar', 
                     day: '12',
                     month: '8',
                     year: '1993')
      within("#new_user") do
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: confirmation
        fill_in 'user_profile_attributes_first_name', with: first_name
        fill_in 'user_profile_attributes_last_name', with: last_name
        select(day, from: 'user_profile_attributes_day')
        select(month, from: 'user_profile_attributes_month')
        select(year, from: 'user_profile_attributes_year')
        choose 'user_profile_attributes_gender_female'
      end
    end
  end
end