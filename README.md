# Gerenciamento de Usuários e Roles

Este é um projeto Flutter que implementa funcionalidades de gerenciamento de usuários e papéis (roles). Ele utiliza uma API REST para realizar operações de CRUD e autenticação.

## Funcionalidades

- **Login**: Autenticação de usuários.
- **Gerenciamento de Usuários**:
    - Listar usuários.
    - Criar novo usuário.
    - Editar informações de um usuário.
    - Deletar usuários.
- **Gerenciamento de Roles**:
    - Listar as roles disponíveis no sistema.

## Estrutura do Projeto

### Pastas Principais

- **models**: Contém os modelos (`User`, `Role`) que representam as entidades do sistema.
- **services**: Contém os serviços para comunicação com a API (`AuthService`, `UserService`).
- **pages**: Contém as telas do aplicativo:
    - `login.dart`: Tela de login.
    - `home.dart`: Tela inicial com a listagem de usuários.
    - `create_user.dart`: Tela para criação de um novo usuário.
    - `edit_user.dart`: Tela para edição de um usuário.
    - `roles_page.dart`: Tela para listagem de roles.

## Configuração

1. Certifique-se de que o Flutter esteja instalado no sistema.
2. Clone o repositório:
   ```bash
   git clone <URL_DO_REPOSITORIO>
