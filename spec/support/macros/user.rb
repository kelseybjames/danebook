module Macros
  module User
    def sign_up(email:        'foo@bar.com',
                password:     'foobar',
                confirmation: 'foobar',
                first_name:   'Foo',
                last_name:    'Bar', 
                day:          '12',
                month:        '8',
                year:         '1993')
      within("#new_user") do
        fill_in 'Email', with: email
        fill_in 'Password', with: password
        fill_in 'Password confirmation', with: confirmation
        fill_in 'First name', with: first_name
        fill_in 'Last name', with: last_name
        select(day, from: 'Day')
        select(month, from: 'Month')
        select(year, from: 'Year')
        choose 'user_profile_attributes_gender_female'
      end
    end

    def log_out
      click_link('Logout')
    end

    def sign_in(email:    'foo@bar.com',
                password: 'foobar')
      fill_in 'email', with: email
      fill_in 'password', with: password
    end

    def write_post
      fill_in 'post_body', with: 'This is a test post'
    end
  end
end