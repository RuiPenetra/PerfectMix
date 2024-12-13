



# PerfectMix

<div style="background-color:#FCC06C; padding: 20px; text-align: center;">
  <img src="https://github.com/RuiPenetra/PerfectMix/blob/master/doc/logo.png" alt="Logo">
</div>

<br>

## Descrição

<p>
A aplicação **PerfectMix** foi desenvolvida no âmbito da unidade curricular de Desenvolvimento para Dispositivos Móveis e tem como objetivo a gestão de receitas culinárias. A aplicação foi criada com base nos requisitos estabelecidos, e, como tal, funcionalidades como a lista de ingredientes e o modo de preparação ainda não foram implementadas, ficando reservadas para desenvolvimentos futuros.

<p>

<br>

<p align="center">
  <img src="https://github.com/RuiPenetra/PerfectMix/blob/master/doc/banner.png" alt="Banner">
</p>

<br>


## Funcionalidades

- **Gestão de Receitas**: Permite a criação, edição e eliminação de receitas de forma simples através da API externa **MockAPI**.

- **Consultar receitas guardadas como favoritas**: As receitas são guardadas num ficheiro **JSON**, garantindo a consulta offline e a atualização automática das receitas locais sempre que houver modificações na API.

- **Organização por Categorias**: As receitas podem ser organizadas e filtradas por categorias, como Itália, China, México, Mediterrâneo, Francesa e Indiana...


## Iniciar

Siga os seguintes passos para configurar o PerfectMix:


### Pré-requisitos

- Um dispositivo com iOS 15 ou superior.

- [Xcode](https://developer.apple.com/xcode/) instalado no seu Mac.

- Conexão à internet.

### Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/RuiPenetra/PerfectMix.git
   ```
2. Navegue até ao diretório do projeto:
   ```bash
   cd perfectmix
   ```
3. Abra o projeto no Xcode:
   - Localize o ficheiro .xcodeproj ou .xcworkspace no diretório do projeto e abra-o no Xcode.

4. Execute a aplicação:
   - No Xcode, selecione o dispositivo ou simulador e clique no botão Play para compilar e executar a aplicação.

 
Este guia assume que o projeto inclui uma parte de desenvolvimento para iOS e que o **Xcode** é necessário para compilar e executar a aplicação na plataforma Apple.



## Utilização

1. Inicie a aplicação **PerfectMix**.

2. Crie uma conta ou inicie sessão.

3. Comece a adicionar as suas receitas favoritas através da interface da API **MockAPI**.

4. Utilize as opções de pesquisa e filtros para encontrar receitas por nome, ingredientes ou categoria (como Itália, China, México, etc.).

5. Partilhe as suas receitas favoritas com amigos e familiares.

6. As receitas podem ser armazenadas localmente num ficheiro **JSON** para consulta offline. Qualquer atualização na API será automaticamente refletida nas receitas guardadas localmente.


## Tecnologias Utilizadas

- **Frontend**: SwiftUI

- **Backend**: **MockAPI** para gestão de receitas e armazenamento de dados

- **Base de Dados**: Dados armazenados no **MockAPI** e localmente em ficheiro **JSON** para consulta offline


## Demonstração

Demonstração prática do funcionamento do projeto. Abaixo, poderá ver o vídeo explicativo:


[![Demo](https://img.youtube.com/vi/oxgpi75OShE/0.jpg)](https://www.youtube.com/watch?v=oxgpi75OShE)



## Licença

Este projeto está licenciado sob a licença MIT - consulte o ficheiro **LICENSE** para mais detalhes.


