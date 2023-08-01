
WEB3DEV
Editar Artigo - WEB3DEV
WEB3DEV
Criar Artigo

Personal
Editar
Visualizar

Post cover
MudarNo file chosenUse a ratio of 100:42 for best results.
Remove
ERC-20 Simplificado: Implementação e Testes Práticos com Foundry
Add up to 4 tagsMaximum 4 selections
Selected items:

Add up to 4 tags...
Bold CTRL + B
Italic CTRL + I
Link CTRL + K
Ordered list
Unordered list
Heading
Quote
Code
Code block
Embed CTRL + SHIFT + K
No file chosenUpload image

ERC-20 é um padrão fundamental para o desenvolvimento de tokens, largamente empregado na rede Ethereum com o objetivo de simplificar a criação de novas criptomoedas.

Neste artigo, aprofundaremos nossos conhecimentos acerca do protocolo ERC-20 e demonstraremos como implementá-lo de forma prática e eficiente por meio do uso do Foundry, uma ferramenta poderosa e acessível para criar e testar nossos contratos.

## O que é ERC-20?
A sigla **ERC** significa "_Ethereum Request for Comments_" ou "**Solicitação de Comentários do Ethereum**", em português. Esses documentos técnicos descrevem os padrões de programação na blockchain da Ethereum e estabelecem convenções que facilitam a interação entre DApps (Aplicativos Descentralizados). O número "20" é o identificador específico dessa documentação.

A proposta do ERC-20 foi criada por _Fabian Vogelsteller_ em 2015, com o **objetivo de oferecer compatibilidade e interoperabilidade entre tokens e DApps na rede Ethereum**, promovendo melhorias no ecossistema.

Além de promover a compatibilidade, o ERC-20 torna o trabalho dos desenvolvedores mais fácil, permitindo que qualquer pessoa crie seus próprios ativos digitais a partir de uma base pré-estabelecida e compatível com outros softwares e serviços, como carteiras de criptomoedas e corretoras.

Cada token criado seguindo o padrão ERC-20 pode ter suas próprias características e parâmetros, permitindo que os desenvolvedores os programem de acordo com suas necessidades específicas.

Devido à sua praticidade e flexibilidade, a Ethereum tem atraído tanto desenvolvedores independentes quanto organizações e empresas. Hoje, já existem mais de **500 mil tokens ERC-20 disponíveis no mercado**, relacionados a projetos variados e com diferentes propósitos. Essa ampla adoção reflete o sucesso do padrão ERC-20 na promoção do crescimento do ecossistema Ethereum.

## Principais características de um token ERC-20
Tokens ERC-20 são criptomoedas que possuem valor próprio e podem ser transferidos e recebidos como qualquer outra moeda digital. Além disso, eles compartilham algumas características em comum, são elas:

- **Nome e símbolo:** Cada token ERC-20 possui um nome e um símbolo que permitem identificá-lo e diferenciá-lo dos demais tokens presentes na rede Ethereum.

-  **Fornecimento:** Os tokens ERC-20 pode ter um fornecimento total predefinido ou não, que determina quantas unidades do token serão emitidas para distribuição na rede.

- **Controle de saldo:** Eles operam por meio de uma interface capaz de mapear, revisar e relatar o saldo contido em um endereço específico da blockchain Ethereum.

- **Transferências:** Os tokens ERC-20 possuem funções que permitem a gestão autônoma do sistema de transferência de fundos entre diferentes endereços da rede.

Com essa compreensão sobre o que é o padrão ERC-20, vamos agora explorar o funcionamento desses tokens em maior detalhe.

## Como os tokens ERC-20 são criados?

O padrão ERC-20 é um conjunto de parâmetros essenciais que um contrato deve atender para garantir a compatibilidade do token com a rede Ethereum. Esses parâmetros, também conhecidos como "EIPs" (**Ethereum Improvement Proposals**) ou **Propostas de Melhoria do Ethereum**, podem ser encontrados no site [Ethereum Improvement Proposals](https://eips.ethereum.org/EIPS/eip-20).

Esses parâmetros correspondem a funções programadas em Solidity, a linguagem de programação da Ethereum. São seis funções obrigatórias e três opcionais. As funções obrigatórias são as seguintes:

1. **TotalSupply**: Retorna o fornecimento total de tokens disponíveis no contrato.

2. **BalanceOf**: Permite verificar o saldo de tokens em um endereço específico.

3. **Transfer**: Realiza a transferência de tokens de um endereço para outro.

4. **TransferFrom**: Similar à função Transfer, mas também permite que um terceiro mova fundos de um endereço com autorização.

5. **Approve**: Limita a quantidade de tokens que um contrato pode retirar de um determinado endereço.

6. **Allowance**: Verifica se um endereço possui saldo suficiente para enviar tokens a outro endereço.

Além dessas funções obrigatórias, existem três funções opcionais que podem ser incluídas para aprimorar o contrato:

1. **Name**: Adiciona um nome legível ao token, como "Tether", "Shiba Inu" ou "Uniswap".

2. **Symbol**: Associa um símbolo ao token, como "USDT", "SHIB" ou "UNI".

3. **Decimal**: Define em quantas casas decimais o token pode ser dividido, proporcionando maior precisão nas transações.

Essas funções definidas pelo padrão ERC-20 garantem a interoperabilidade entre diferentes tokens e dApps na rede Ethereum, facilitando o desenvolvimento e o uso de ativos digitais de forma segura e eficiente.

## Como criar um token ERC-20?
Para criar um token ERC-20, é necessário escrever um contrato inteligente em Solidity, que é a linguagem de programação utilizada na blockchain da Ethereum. Esse contrato é essencialmente um código que estabelece as regras de funcionamento do token, incluindo o fornecimento total, o nome, o símbolo e as funções que o token executará.

Para auxiliar no desenvolvimento do contrato ERC-20, o site da [OpenZeppelin](https://docs.openzeppelin.com/contracts/4.x/api/token/erc20) oferece informações detalhadas sobre cada função necessária, seus parâmetros e possíveis extensões para o contrato. Essa documentação é uma fonte valiosa de referência e orientação para os desenvolvedores que desejam implementar tokens ERC-20 com segurança e conformidade com o padrão estabelecido.

Ao seguir essas diretrizes e aproveitar os recursos disponíveis na OpenZeppelin, é possível criar tokens ERC-20 que se integram facilmente ao ecossistema Ethereum e oferecem diversas funcionalidades e oportunidades no contexto de aplicativos descentralizados e sistemas financeiros.
## Criando um token ERC-20 com Foundry

Utilizaremos o [Contracts Wizard](https://docs.openzeppelin.com/contracts/4.x/wizard) da OpenZeppelin para criar a base do nosso contrato e, em seguida, implementá-lo com o auxílio do Foundry.

O Contracts Wizard da OpenZeppelin é uma ferramenta valiosa que nos permitirá criar facilmente a estrutura inicial do contrato, garantindo que ele siga as diretrizes do padrão ERC-20 de forma segura e confiável. Com essa base sólida, poderemos prosseguir para a implementação do contrato utilizando o Foundry.

O Foundry é uma ferramenta poderosa que agiliza e facilita o desenvolvimento de contratos inteligentes na rede Ethereum. Com ele, seremos capazes de personalizar e adicionar as funcionalidades específicas do nosso token ERC-20, garantindo uma implementação robusta e eficiente.

Ao utilizar essa combinação de recursos da OpenZeppelin e do Foundry, estaremos bem preparados para criar um token ERC-20 de alta qualidade, pronto para interagir perfeitamente com outros contratos e aplicativos na rede Ethereum.
### Criando contrato ERC-20 com Contracts Wizard

Optamos pela opção ERC20 no Contracts Wizard e, em seguida, preenchemos os campos com as informações do nosso token, como Nome e Símbolo. Escolhemos também habilitar as opções "Mintable" (possibilidade de criação de novos tokens) e "Burnable" (possibilidade de destruição de tokens).

A imagem abaixo mostra um exemplo de como ficou o contrato ERC20 após a configuração no Contracts Wizard:

![Exemplo de contrato ERC20 no Contracts Wizard](https://web3dev-forem-production.s3.amazonaws.com/uploads/articles/43vd2up1vn3bv6qok82e.png)

Com essas definições, nosso contrato estará preparado para operar como um token ERC20, permitindo transferências, criação e destruição de tokens, conforme as necessidades do nosso projeto. Essa configuração nos proporciona flexibilidade e controle para gerenciar o nosso token na rede Ethereum de maneira eficiente.

### Implementando contrato ERC-20 com Fondry

Se você ainda não está familiarizado com o Foundry e deseja aprender como instalá-lo em sua máquina e utilizá-lo, recomendo verificar este tutorial [aqui](https://www.web3dev.com.br/diogoj/iniciante-em-web3-como-usar-o-foundry-para-testar-um-contrato-erc20-com-fuzzing-2pfi). Ele fornecerá uma compreensão mais aprofundada sobre o funcionamento do Foundry.

Para começar a implementar o seu projeto, inicie um novo projeto com o comando `forge init`. Em seguida, crie um novo arquivo chamado `MyToken.sol` dentro da pasta `src` e cole o conteúdo do contrato gerado pelo **Contracts Wizard**.

Antes de prosseguirmos, realizaremos uma mudança em nosso `constructor` para permitir a definição do nome e símbolo do nosso token durante o deploy. Adicione o seguinte código ao contrato:

```solidity
constructor (string memory _name, string memory _symbol) ERC20 (_name, _symbol) {
}
```

Com essa alteração, poderemos configurar o nome e o símbolo do token de forma flexível ao implantar o contrato.

Como implementaremos nosso contrato utilizando as interfaces do OpenZeppelin, é necessário instalar o pacote com o seguinte comando:
```bash
forge install openzeppelin/openzeppelin-contracts
```

Se você estiver utilizando o VSCode, talvez receba algumas mensagens de erro. Para corrigir esse problema, execute o seguinte comando:
```bash
forge remappings > remappings.txt
```
Em seguida, adicione a linha a seguir no arquivo `remappings.txt`: `@openzeppelin/=lib/openzeppelin-contracts/`. Essa alteração permitirá a correta importação das interfaces do OpenZeppelin.

Na pasta `test`, crie um arquivo chamado `MyToken.test.sol` e copie o código de testes disponível neste [gist](https://gist.github.com/viniblack/5c6290a3352eaa62465f767e07ddfe54).

Ao seguir esses passos, você estará preparado para testar e implementar o seu contrato ERC20 utilizando o Foundry e as interfaces do OpenZeppelin. Esse processo é crucial para garantir a segurança e o correto funcionamento do seu token na rede Ethereum. Desejo boa sorte em seu projeto!

### Rodando os testes

Para executar todos os testes do seu projeto, utilize o seguinte comando:
```bash
forge test
```
Caso deseje executar um teste específico, utilize o comando abaixo, substituindo "testMint" pelo nome do teste desejado:
```bash
forge test -m testMint
```
Para rodar os testes e gerar um relatório de consumo de gas, utilize o seguinte comando:
```bash
forge test --gas-report
```

O relatório de consumo de gas fornecerá informações valiosas sobre o custo em gas de cada função testada, como mostrado na imagem abaixo:
![Gas Report](https://web3dev-forem-production.s3.amazonaws.com/uploads/articles/i001ub2g7deuqt9xbab4.png)

Essas ferramentas de teste e análise de gas são essenciais para garantir a qualidade e a eficiência do seu contrato ERC20. Utilize-as para verificar o desempenho do seu contrato e garantir que ele funcione conforme o esperado na rede Ethereum.

## Referências

- [ERC-20: O que é e como funciona esse tipo de token?](https://coinext.com.br/blog/erc-20)
- [ERC-20: Token Standard](https://eips.ethereum.org/EIPS/eip-20)
- [ERC 20](https://docs.openzeppelin.com/contracts/4.x/api/token/erc20#extensions)
- [Testes Foundry](https://book.getfoundry.sh/forge/tests)
- [Testando ERC-20 com Foundry](https://github.com/Atarpara/openzeppeline-erc20-foundry-test)

Essas referências fornecem informações valiosas sobre o padrão ERC-20, detalhes técnicos, implementação de contratos e testes com o Foundry. Recomendamos explorá-las para aprofundar seus conhecimentos e garantir uma melhor compreensão do assunto.

## Conclusão

Essa foi uma explicação simplificada do que é um token ERC-20 e como implementá-lo e testá-lo utilizando o Foundry e os padrões da OpenZeppelin.

Se este conteúdo foi útil e te ajudou de alguma forma, ficaríamos muito agradecidos se você deixasse um like para ajudar a compartilhar esse conhecimento com mais pessoas.

![Deixa um like](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/7quw5wii7e1aihephclv.gif)

---

### Link do repositório

Para mais detalhes e o código fonte do exemplo, acesse o repositório no GitHub: [Foundry ERC20 Implementation](https://github.com/viniblack/foundry-erc20-implementation)

### Vamos trocar uma ideia?

Fique à vontade para me contatar para trocarmos uma ideia ou tirar dúvidas.
Você pode me encontrar no LinkedIn: [viniblack](https://www.linkedin.com/in/viniblack/).
Será um prazer conversar contigo!

Escrevendo um Título de Artigo Atrativo
Pense no título da sua postagem como uma descrição super curta (mas atraente!)
Como uma visão geral da postagem real em uma frase curta. Use palavras-chave quando apropriado para ajudar a garantir que as pessoas possam encontrar sua postagem por pesquisa.
Salvar