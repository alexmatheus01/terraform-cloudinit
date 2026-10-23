# Provisionamento de Infraestrutura na AWS com Terraform e Cloud-Init

Este repositório foi criado para demonstrar a criação de uma Infraestrutura como Código (IaC), onde será automatizado o provisionamento de uma VM Linux utilizando Terraform. A configuração inicial da máquina será realizada pelo Cloud-Init. Também será utilizado o GitHub Actions para verificar e validar os arquivos Terraform por meio de uma pipeline.


## Tecnologias Utilizadas

- **AWS (Amazon Web Services)**: Provedor de nuvem para hospedar a infraestrutura provisionada.
- **Terraform**: Ferramenta de Infraestrutura como Código (IaC).
- **Cloud-Init / user-data.yml**: Automação da inicialização da VM (instalação de Docker e Nginx).
- **GitHub Actions**: Pipeline de CI/CD para validação e execução automática.

---

## Estrutura do Repositório

.
├── .github/
│   └── workflows/
│       └── terraform.yml 
├── .gitignore               
├── main.tf                  
├── outputs.tf               
├── user-data.yaml            
└── README.md                

---

## Arquivos do repositório

*main.tf*: contém a configuração Terraform responsável por provisionar a máquina virtual e demais recursos necessários.

*outputs.tf*: apresenta informações geradas após o provisionamento da VM, como o ID e o endereço IP público da instância.

*user-data.yaml*: contém as configurações a serem executadas pelo Cloud-Init durante a inicialização da máquina.

*.github/workflows/terraform.yml*: define a pipeline CI/CD que será executada pelo GitHub Actions.

*.gitignore*: impede que arquivos locais, estados do Terraform e informações sensíveis sejam versionadas e enviadas ao repositório.

*README.md*: apresenta a documentação e instruções básicas.


OBS: Dentro de cada arquivo há uma descrição do que cada comando realiza.


## Para executar a atividade é necessário que cada usuário possua:

- Terraform instalado;
- Git instalado;
- conta e credenciais válidas no provedor de nuvem utilizado;
e acesso ao GitHub para execução da pipeline.