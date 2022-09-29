Feature: Cadastro com nome email documento e senha
  Para conseguir ter acesso ao aplicativo
  Como um usuario

  Scenario: Usuario fornece credenciais validas
    Given os dados de um usuario que quer se cadastrar
    When ele clica no botão para fazer o cadastro na aplicação
    Then o usuario deve ter sido cadastrado na aplicação com os valores que ele inseriu

  Scenario: Usuario tenta se cadastar mas ja existe um outro usuario com o mesmo email na aplicação
    Given os dados de um usuario que quer se cadastrar
    When ele clica no botão para fazer o cadastro na aplicação
    When ele clica no botão para fazer o cadastro na aplicação
    Then só deve existir um usuario cadastrado
    And a reposta deve ter um erro de E-mail já está em uso

  Scenario: Usuario fornece e-mail inválido
    Given dados de um usuario com um e-mail inválido
    When ele clica no botão para fazer o cadastro na aplicação
    Then não deve ter nenhum usuario na aplicação
    And a reposta deve ter um erro de E-mail não é válido

  Scenario: Usuario fornece uma senha com menos de 6 caracters
    Given dados de um usuario com uma senha com menos de 6 caracters
    When ele clica no botão para fazer o cadastro na aplicação
    Then não deve ter nenhum usuario na aplicação
    And a resposta deve ter um erro de Senha muito pequena, tamanho mínimo é 6 caracteres
