Given('um usuario da aplicacao') do
  @user = FactoryBot.create(:user)
end

When('ele fornece as credenciais validas') do
  @auth = { email: @user.email, password: @user.password }
end

When('ele clica no botão para fazer o login') do
  @test_client = TestClient.new
  @user_login_response = @test_client.login('api/v1/users/sign_in', @auth)
end

Then('ele deve estar autorizado a acessar a aplicacao') do
  auth_response = Users::SessionService.call(session_params: @auth)
  expect(auth_response.success?).to be true
end

When('ele fornece as credenciais invalidas') do
  @invalid_auth = { login: 'invalid@gmail.com', password: 'invalid' }
end

Then('ele nao deve estar autorizado a acessar a aplicacao') do
  auth_response = Users::SessionService.call(session_params: @invalid_auth)
  expect(auth_response.success?).to be false
end

Then('o usuario deve ter um token valido') do
  @user.reload
  expect(@test_client.headers['HTTP_USER_TOKEN']).to be_truthy
  expect(@test_client.headers['HTTP_USER_EMAIL']).to be_truthy
  expect(@test_client.headers['HTTP_USER_EMAIL']).to eq(@user.email)
  expect(@user.token_match?(@test_client.headers['HTTP_USER_TOKEN'])).to be_truthy
  expect(@user.token_match?(@user_login_response[:token])).to be true
end
