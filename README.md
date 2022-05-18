# Desafio Capyba

## Requisitos

### Login e Cadastro
- [x] Cadastro e login via email
- [ ] Exigir selfie do usuário no cadastro
- [x] Após o login da pessoa, caso ela feche o app e abra de novo,
o app deve continuar logado e mostrar a página de home

### Área para pessoas logadas
- [x] Área logada contém duas abas, "Home"e"Restrito"
- [x] Área de Home é acessível para qualquer pessoa logada
- [ ] Área Restrita só é acessível para pessoas que tenham confirmado seu email

### Meu perfil
- [ ] Implementar uma página "Meu Perfil", acessível via um menu lateral
- [ ] Na página de "Meu Perfil", a pessoa poderá editar suas informações de cadastro

### Dados
- [ ] Criar uma collection "home" onde haverá documentos a serem mostrados
na aba de "Home" do app
- [ ] Criar uma collection "restricted" onde haverá documentos a serem mostrados
na aba de "Restrito" do app
- [ ] As informações das collections e como serão exibidos (layout) os documentos
em cada aba fica a critério de vocês

### Confirmação de e-mail
- [ ] Adicionar uma opção no menu lateral "Validar Email" que direcionará o usuário
para a tela de confirmação de e-mail

### Bônus
- [ ] Cadastro e login via Google
- [ ] O Firebase pode ter access rules que não permitam uma pessoa editar
dados de outra pessoa
- [ ] O Firebase pode ter access rules que não permitam uma pessoa editar o status
de verificação de seu próprio e-mail
- [ ] O Firebase pode ter access rules que permitam que somente pessoas logadas
possam acessar os documentos da collection "home"
- [ ] O Firebase pode ter access rules que permitam que somente pessoas logadas
possam e com e-mail verificado possam acessar os documentos da collection "restricted"