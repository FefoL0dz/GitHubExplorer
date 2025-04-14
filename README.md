# # 📱 GitHub Explorer

GitHub Explorer é um aplicativo iOS nativo construído com **SwiftUI + Clean Architecture**, que permite buscar e explorar usuários e repositórios do GitHub de maneira fluida, elegante e com uma base de código altamente testável.

---

## 🚀 Funcionalidades

- 🔍 **Buscar usuários do GitHub** com debounce automático
- 👤 **Visualizar detalhes do perfil** (nome, bio, seguidores, seguindo)
- 📦 **Listar repositórios de um usuário**
- 📂 **Visualizar detalhes de repositórios** (stars, forks, issues, linguagem, última atualização)
- 🧪 **Arquitetura com testes unitários completos**
- 🔀 **Consulta com debounce usando Combine**
- 🧩 **Base de código modular com Clean Architecture**

---

## 🛠 Arquitetura

Este projeto segue os princípios da **Clean Architecture**, com separação clara entre as camadas:

GitHubExplorer/
├── Application/
│   | 
│   └── GitHubExplorerApp.swift
├── Presentation/
│   ├── Views/
│   │   ├── UserListView.swift
│   │   ├── UserDetailView.swift
│   │   ├── RepoDetailView.swift
│   │   └── Components/ (UserRow, RepoRow, etc. reusable components)
│   ├── Helpers/
│   │   ├── IdentifiableError.swift
│   │   └── DebouncedPublisher.swift
│   └── ViewModels/
│       ├── UserListViewModel.swift
│       ├── UserDetailViewModel.swift
│       └── RepoDetailViewModel.swift
├── Domain/
│   ├── Entities/
│   │   ├── User.swift
│   │   ├── UserProfile.swift
│   │   └── Repository.swift
│   ├── UseCases/
│   │   ├── GetUserListUseCase.swift
│   │   ├── SearchUsersUseCase.swift
│   │   ├── GetUserProfileUseCase.swift
│   │   ├── GetUserReposUseCase.swift
│   │   └── GetRepoDetailUseCase.swift
│   └── Repositories/
│       ├── UserRepository.swift
│       └── RepoRepository.swift
├── Data/
│   ├── Network/
│   │   ├── GitHubAPIError.swift
│   │   ├── GitHubAPI.swift
│   │   └── GitHubAPIClient.swift
│   ├── Persistence/
│   │   ├── CoreDataStack.swift
│   │   ├── UserLocalDataSource.swift
│   │   └── RepoLocalDataSource.swift
│   ├── Mappers/
│   │   ├── UserDTO.swift
│   │   ├── UserProfileDTO.swift
|   |   ├── RepositoryDTO.swift
│   │   └── UserSearchResponseDTO.swift
│   └── RepositoriesImpl/
│       ├── UserRepositoryImpl.swift
│       └── RepoRepositoryImpl.swift
├── Resources/
│   └── GitHubExplorer.xcdatamodeld
└── Tests/
    ├── GitHubAPIMock.swift
    ├── DebouncedPublisherTests.swift
    ├── UserRepositoryImplTests.swift
    └── ... etc.



### Padrões Utilizados

- ✅ MVVM com Clean Architecture
- ✅ Injeção de dependência via construtor
- ✅ Separação de responsabilidades por domínio
- ✅ Programação reativa com Combine
- ✅ Concurrency com `async/await`

---

## 📦 Dependências

**Nenhuma dependência externa!**

Utiliza apenas frameworks nativos da Apple:

- SwiftUI
- Combine
- Foundation
- XCTest

---

## 🌐 Integração com a API do GitHub

Utiliza a [API REST pública do GitHub](https://docs.github.com/pt/rest):

- `/search/users`
- `/users/:username`
- `/users/:username/repos`
- `/repos/:owner/:repo`

⚠️ A aplicação utiliza requisições **não autenticadas** por padrão. Suporte a OAuth é uma opção de melhoria.

---

## 🧪 Testes

O projeto possui uma **cobertura abrangente de testes unitários**:

| Camada         | Testada? |
|----------------|----------|
| ✅ Entidades         S    | `User`, `UserProfile`, `Repository` |
| ✅ Casos de uso      S    | Todos os 5 casos |
| ✅ Repositórios      S    | `UserRepositoryImpl`, `RepoRepositoryImpl` |
| ❌ ViewModels        N    | `UserListViewModel`, `UserDetailViewModel`, `RepoDetailViewModel` |
| ✅ Helpers           S    | `DebouncedPublisher`, `IdentifiableError` |
| ✅ Camada de API     S    | `GitHubAPIClient` com `MockURLProtocol`

Os testes são isolados e organizados em `GitHubExplorerTests/`, com mocks personalizados para simular comportamentos.

---

## 📂 Como Rodar o Projeto

1. Clone o repositório:
   git clone https://github.com/FefoL0dz/GitHubExplorer.git
   cd GitHubExplorer

2. Abra no Xcode:
   open GitHubExplorer.xcodeproj

3. Compile e execute:
  ⌘ + R
   
4. Execute os testes:
  ⌘ + U
  
Requisito mínimo: iOS 15+

📌 Sugestoes de melhorias
Os seguintes recursos sao sugestoes de melhoria:

 💾 Cache offline com Core Data

 🌙 Suporte completo ao Modo Escuro

 🌎 Suporte à localização e internacionalização

 🔐 Autenticação via OAuth para aumentar o limite de requisições
 
 🧪 Implementar mais testes unitários para cobrir as camadas restantes
 
 💉 Melhorar a Injeção de Dependência implementando algum DI Container
 
 🛜 Usar uma abordagem mais Offline first,
    armazenando os dados localmente e evitando excesso de requisições para a API

 ✨ Melhorias visuais com animações e transições
 
  📑 Melhorias na implementação da paginação da lista de usuários
  
  ⛔ Correção do erro: ❌ Error on loadMoreUsers: httpError(403) ao tentar obter mais resultados de usuários
  (Possivelmente relacionado ao limite de requisições para chamadas não autenticadas)
 
  💻 Melhorias gerais de código (organizacao do projeto, divisao de responsabilidades, nomenclaturas...)

