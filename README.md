# Api template v2.0.0 - Web

<!-- TABLE OF CONTENTS -->

<details open="open">
   <summary>
      <h2 style="display: inline-block">Tabela de Conteúdos</h2>
   </summary>
   <ol>
      <li><a href="#dependências">Dependências</a></li>
      <li><a href="#setup-do-projeto">Setup do Projeto</a>
         <ul>
            <li><a href="#setup-api-only">Se for só api</a></li>
         </ul>
      </li>
      <li><a href="#testes">Testes</a></li>
      <li><a href="#documentação-no-postman">Documentação</a></li>
   </ol>
</details>

---

## Dependências

- Ruby v3.0.3
- Rails v6.1.4.1
- MySQL v8.0.26-0
- Git e Git Flow

---

## Setup do Projeto

### **1. Download**

Acesse via terminal o local dos seus projetos e faça o download do repositório com o seguinte comando:

```bash
git clone git@gitlab.com:jera-software/api-template.git
```

### **2. Ruby**

Caso não tenha Ruby instalado em sua máquina, recomendamos o uso do RVM para a instalação do mesmo.

Links para o setup de sua máquina, caso ainda não tenha feito:

- [Passo a Passo no Boas Praticas](https://jera-software.gitlab.io/boas-praticas-web/#/web/api/setup-ambiente)

- [Video tutorial](https://www.youtube.com/watch?v=63R0OOOOPfw)

### **3. Apontando o GIT para o repositório certo**

Antes de começar a codar, você precisa substituir a origin do repositório da api-template pelo seu

```
git remote remove origin
git remote add origin <GIT_DO_PROJETO>
git push -f origin main
git push -u origin --all
git push -u origin --tags
```

### **4. Nome da Aplicação**

No arquivo `application.rb` apague a linha `raise 'Mude o nome do módulo AppTemplate...'`

Caso você esteja utilizando o editor VsCode:

- Com seu projeto aberto, use o comando `ctrl + shift + f` e cole o termo `api_template` no campo de busca. Este comando irá buscar por todos os arquivos que possuam este termo;

- Substitua todas as ocorrências de `api_template` nos arquivos pelo nome da sua aplicação utilizando o padrão `snake_case`.

- Faça o mesmo procedimento para o termo `AppTemplate`. Lembrando de utilizar o padrao `PascalCase` neste cenário.

Caso esteja utilizando outro editor, procure uma maneira de pesquisar todas as ocorrências para o termo `api_template` e `AppTemplate`.

### OBS: Não mudar no `README.md`

### **5. Criação e Configuração do arquivo `config/database.yml`**

Primeiramente é necessário criar o arquivo de setup do banco de dados executando no console o comando abaixo, no qual será criado o arquivo `config/database.yml`, sendo uma cópia do `config/database.example.yml`

```bash
cp config/database.example.yml config/database.yml
```

### OBS: Caso já tenha feito a configuração do MySql e sua senha não seja `root`, a troque na linha 7 do arquivo.

### **6. Atualizar o `Gemfile`**

É muito importante que você atualize as gems e a versão do ruby ao criar um novo projeto, com o objetivo de evitar problemas de segurança ou até mesmo erros em algumas gems que utilizamos e que já foram corrigidas nas versões mais recentes.

Execute a task rails(comando abaixo) no console, ela é responsável pela atualização do arquivo Gemfile:

```bash
rake gemfile:update
```

- OBS: Caso ele reclame que a versão especificada no Gemfile não esteja instalada na máquina: `Your Ruby version is 3.0.X, but your Gemfile specified 3.0.Y`, execute o comando:

  ```bash
  rvm install 3.0.Y
  ```

- Onde, `3.0.Y` é a versão que ele informou no alerta acima.

- Após isso execute o comando `rake gemfile:update` novamente.

- Após o seu Gemfile ser atualizado com sucesso, delete o arquivo Gemfile.lock do seu projeto, caso exista.

### **7. Gemset e RubyVersion**

Dentro da pasta do projeto crie, caso não exista, os arquivos `.ruby-version` e `.ruby-gemset`.

Verifique se o atributo `ruby_version` nos arquivos `.gitlab-ci.yml` e `config/deploy.rb` tem o mesmo valor do atributo `ruby` no arquivo `Gemfile`.

Caso esteja tudo certo execute o comando abaixo no console do seu projeto.

### OBS: Troque `ruby_version` e `api_template` pela versão do ruby e nome da sua aplicação (a mesma usada no passo 4 e mantenha as aspas).

```bash
echo "ruby_version" > .ruby-version && echo "api_template" > .ruby-gemset
cd .
```

### OBS: Caso mude a versão no arquivo `Gemfile` também é necessário mudar nos arquivos `.gitlab-ci.yml` e `config/deploy`.

### **8. Instalar gems**

A ferramenta `bundle` instalará todas as gems que foram definidas no Gemset do projeto.

Execute o comando abaixo para usar a versão do ruby que foi configurada no arquivo `ruby_version`, do tópico 7.

```bash
rvm use
```

Outro problema que pode acontecer, é dele reclamar que a versão especificada no Gemfile não está instalada na máquina `Your Ruby version is 3.0.X, but your Gemfile specified 3.0.Y`, então execute o comando:

```bash
rvm install 3.0.Y
```

Onde, `3.0.Y` é a versão que ele informou no alerta acima.

Em seguida execute o comando para instalar todas as gems que foram definidas no Gemset do projeto.

```bash
gem install bundle && bundle install
```

Pode acontecer de haver um erro de dependência, isso acontece por causa de uma versão X de uma gem específica não ser compatível com outra gem na versão Y. Nesse caso, arrume os erros de dependencia! Se precisar de ajuda, chame o time web-dev para te ajudar.

### **9. Rails db**

Por fim, crie o banco de dados, rode as migrations e gere os seeds

```bash
rails db:create db:migrate db:seed
```

### **10. Configuração do Sentry e o NewRelic**

Link para auxilio na configuração do Sentry e do NewRelic:

- [Configuração do Sentry](https://jera-software.gitlab.io/boas-praticas-web/#/web/setups/setup-sentry?id=configurando-sentry-da-sua-aplica%c3%a7%c3%a3o)

- [Configuração do NewRelic](https://jera-software.gitlab.io/boas-praticas-web/#/web/setups/setup-new-relic?id=adicionando-o-newrelic-no-seu-projeto)

### **11. Configurações Adicionais**

Caso esteja começando um projeto novo vamos precisar deletar o arquivo `credentials.yml.enc` e se já estiver criada, delete a `master.key`.

Agora basta executar o comando abaixo:

OBS: Caso não possua o `vim` utilize o `nano`.

```bash
EDITOR=vim rails credentials:edit
```

Ele automaticamente irá abrir o arquivo que contem as credentials do seu ambiente de desenvolvimento, copie e cole o código a seguir na linha abaixo da secret_key_base.

```bash
development:
   admin_username: 'admin'
   admin_password: 'secret123'
staging:
   admin_username: 'admin'
   admin_password: 'secret123'
production:
   admin_username: 'admin'
   admin_password: 'secret123'
```

Para salvar no `vim` tecle esc e digite `:wq!`

Para salvar no `nano` tecle `ctrl + o` e depois `enter` para sair.

Após isso a `master.key` foi gerada, ela deve ser adicionada no Git. Para isso, no arquivo `.gitignore` comente a linha `/config/master.key`, adicione ela ao GIT fazendo apenas um commit e depois descomente a linha no `.gitignore` de novo.

### **12. Docker (opcional)**

Caso queira utilizar docker em desenvolvimento, é só rodar o docker-compose do proejto

```bash
docker-compose up
docker-compose run application rake db:create db:migrate db:seed
```

### **13. Configurando git-flow**

Para utilização do ambiente de desenvolvimento configure o Git Flow.

Se ainda não tiver ele instalado em sua máquina execute o seguinte comando no console, de preferência na raiz dos diretórios:

```bash
$ sudo apt-get install git-flow
```

Após instalado, execute o proximo comando no console, na pasta do projeto:

```bash
$ git flow init
```

Pressione Enter para todas as opções que serão exibidas. Depois disso você já estara na branch de development.

Caso opte por não utilizar Git Flow, é necessário fazer o download da branch `develop` remota.

---

## Testes

Utilizamos o framework Rspec e cucumber para execução de testes.

Para executar manualmente:

```bash
rake rspec
rake cucumber
```

Para executar com Docker:

```bash
docker-compose up
docker-compose run application rake db:create db:migrate db:seed RAILS_ENV=test
docker-compose run application spring rspec
```

---

## Documentação no Postman

Todo projeto de API deve ser documentado.
Durante o setup, é importante criar uma conta no Postman para o projeto, ou se preferir, pode utilizar a conta da Jera também. Caso precise de ajuda com isso, basta chamar alguém no canal web-dev.

- Não esqueça de editar os Merge Request Templates com o link da documentação :D

---

<!--> ================================= ATENÇÃO =================================<!-->
<!--> OBS: Caso seu projeto tenha front web com Vue ou outra tecnologia, apague essa parte do README<!-->

## Setup Api Only

Se sua aplicação **não** for só API e tiver uma parte WEB RAILS execute os seguintes passos:

- Primeiro, em `application.rb` troque a linha `config.api_only = true` por `config.api_only = false`;
- Então descomente as gems de `Assets` no arquivo `Gemfile` e rode `bundle install` para instalar as dependências necessárias;
- Agora rode o comando `rails webpacker:install` que vai fazer todo o setup necessário pra seu front.
- Para funcionar no ambiente de staging, você vai precisar criar na pasta do webpack o arquivo `staging.js`, você pode se basear no `production.js` para fazer isso. (Leia mais sobre o Webpacker aqui https://github.com/rails/webpacker)
- Se sua aplicação não tiver sidekiq, remova o arquivo `app/workers/base_worker.rb`
- Na migration que cria o User foram criadas as seguintes linhas:

  ```ruby
     # Omniauth
     # t.string :provider, :null => false, :default => "email"
     # t.string :uid, :null => false, :default => ""
  ```

- Elas são criadas pelo devise pra usar facebook ou algum outro provider de login (ex. google, apple). Para entender melhor como funciona o devise: https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview

---
