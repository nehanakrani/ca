# Citizens Advice Challenge:
Create a ruby based application for a user registration and authentication system. It should be designed as a REST-ful API with JSON only responses, there is no need for views.

- Users need to be able to register with a username, email address and password (there is no need to send confirmation email).
- Users need to be able to authenticate with their username and password.
- When a user is successfully authenticated, the API needs to respond with a unique user token.
- Groups have a unique name and can have many users and users can belong to many groups.
- Some users have admin privileges and they need to be able to carry out the following actions using a valid user token:
    1. Create groups.
    2. Assign users to groups.

# Solution Approach:
 - Create Rails API using Ruby 3.2.0 and rails 7.0.4

 - Create an Authenticate API for users with using gem 'devise_token_auth'

 - For API Example, I can attach here one Postman Link to test

 - Create user with admin flag true or false therefore didn’t go through with role based assignment in such case for different privileges, In solution we can use pudit either cancan to provide user to Authorization.

 - Groups have a unique name and can have many users and users can belong to many groups.in that case, I have used  NxN (many to many) relationships therefore model generate it like this: Group/User relationship using join table has_many :users, :through => :user_groups, For that I have only created methods to create groups and a method as assigned user in to group.

## Setup:
1.  Install ruby `3.2.0`
2. `gem install bundler`
3. `bundle install`
4. `rails db:setup`
5. `rails server`

## Tests:
- bundle exec rspec spec

## Testing Endponits:

- User sign up user with endpoint `Sign_up`:
>   curl --location --request POST 'http://localhost:3000/auth' \
    --form 'email="test@gmail.com"' \
    --form 'password="test12345"' \
    --form 'password_confirmation="test12345"'
    --form 'admin="true"' \
    --form 'first_name="Test First Name"' \
    --form 'last_name="Test Last Name"' \
    --form 'username="Test Username"'

- User sign in user with endpoint `Sign_in`:
>   curl --location --request POST 'http://localhost:3000/auth/sign_in' \
    --form 'email="test@gmail.com"' \
    --form 'password="test12345"'

- Create groups with endpoint `Add group`:
>   curl --location --request POST 'http://localhost:3000/api/v1/groups' \
    --header 'Content-Type: application/json; charset=utf-8' \
    --header 'Vary: Accept, Origin' \
    --header 'access-token: BpfHqs3-TfiqhhHBl9KA8Q' \
    --header 'token-type: Bearer' \
    --header 'client: kTjGgbHnrmWva7-S0ZDGhg' \
    --header 'expiry: 1674945994' \
    --header 'uid: test@gmail.com' \
    --header 'Authorization: Bearer eyJhY2Nlc3MtdG9rZW4iOiJCcGZIcXMzLVRmaXFoaEhCbDlLQThRIiwidG9rZW4tdHlwZSI6IkJlYXJlciIsImNsaWVudCI6ImtUakdnYkhucm1XdmE3LVMwWkRHaGciLCJleHBpcnkiOiIxNjc0OTQ1OTk0IiwidWlkIjoibmVoYW5ha3JhbmkwOEBnbWFpbC5jb20ifQ==' \
    --data-raw '{
        "name": "test group name"
    }'

- Assign users to groups with endpoint `assigned_users`:
>   curl --location --request POST 'http://localhost:3000/api/v1/  groups/14/assigned_users' \
    --header 'Authorization: Bearer eyJhY2Nlc3MtdG9rZW4iOiI2aENDZkhKamQ2X2loWU1rQ3ltVjdnIiwidG9rZW4tdHlwZSI6IkJlYXJlciIsImNsaWVudCI6ImNMRE91UzlBTlRGR3V2eVA5THB2SWciLCJleHBpcnkiOiIxNjc1MDM3Mjc3IiwidWlkIjoibmVoYW5ha3JhbmkwMDlAZ21haWwuY29tIn0=' \
    --header 'Content-Type: application/json; charset=utf-8' \
    --header 'Vary: Accept, Origin' \
    --header 'access-token: 6hCCfHJjd6_ihYMkCymV7g' \
    --header 'token-type: Bearer' \
    --header 'client: cLDOuS9ANTFGuvyP9LpvIg' \
    --header 'expiry: 1675037277' \
    --header 'uid: test@gmail.com' \
    --data-raw '{
        "user_ids": [
            1, 2
        ]
    }'