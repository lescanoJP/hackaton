Given('os dados de um usuario que quer se cadastrar') do
  @new_user_params = {
    name: 'Diogo',
    email: 'diogo@jera.com.br',
    document: CPF.generate,
    password: 'secret123',
    password_confirmation: 'secret123'
  }
end

Given('dados de um usuario com um e-mail inválido') do
  @new_user_params = {
    name: 'Diogo',
    email: 'diogo@',
    document: CPF.generate,
    password: 'secret123',
    password_confirmation: 'secret123'
  }
end

Given('dados de um usuario com uma senha com menos de 6 caracters') do
  @new_user_params = {
    name: 'Diogo',
    email: 'diogo@jera.com.br',
    document: CPF.generate,
    password: '123',
    password_confirmation: '123',
  }
end

Given('um usuario ja cadastrado na aplicação') do
  @user = FactoryBot.create(:user)
end

When('ele clica no botão para fazer o cadastro na aplicação') do
  test_client = TestClient.new
  @create_user_response = test_client.make_post('api/v1/users', @new_user_params)
end

Then('o usuario deve ter sido cadastrado na aplicação com os valores que ele inseriu') do
  @created_user = User.find_by(email: @new_user_params[:email])
  expect(@created_user.present?).to be_truthy
  expect(@created_user.name).to eq(@new_user_params[:name])
end

Then('só deve existir um usuario cadastrado') do
  expect(User.count).to be 1
end

Then('a reposta deve ter um erro de E-mail não é válido') do
  expect(@create_user_response[:errors]).to be_truthy
  expect(@create_user_response[:errors].first).to include('não é válido')
end

Then('a reposta deve ter um erro de E-mail já está em uso') do
  expect(@create_user_response[:errors]).to be_truthy
  expect(@create_user_response[:errors].first).to include('já está em uso')
end

Then('não deve ter nenhum usuario na aplicação') do
  expect(User.count).to be 0
end

Then('a resposta deve ter um erro de Senha muito pequena, tamanho mínimo é 6 caracteres') do
  expect(@create_user_response[:errors]).to be_truthy
  expect(@create_user_response[:errors].first).to include('Senha muito pequena, tamanho mínimo é 6 caracteres')
end
