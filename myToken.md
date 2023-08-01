ERC-20 é uma estrutura padrão para desenvolvimento de tokens, usada na rede Ethereum para facilitar a criação de novas criptomoedas.
Nesse artigo vamos aprender um pouco mais sobre ERC-20 e como implementar ele utilizando Foundry

## O que é ERC-20?
A sigla **ERC** significa "_Ethereum Request for Comments_" ou **Solicitação de Comentários do Ethereum**, em português. Tratam-se de documentos técnicos que descrevem os padrões de programação na Ethereum e estabelecem convenções que facilitam a interação entre DApps. Já o número “20” é o identificador dessa documentação. 

A proposta foi criada por Fabian Vogelsteller em 2015, com o objetivo de oferecer compatibilidade e interoperabilidade entre os tokens e DApps da rede, promovendo melhorias no ecossistema Ethereum.

Seu uso também facilita o trabalho de desenvolvedores: ao seguir o esboço de desenvolvimento do ERC-20, **qualquer um pode simplesmente construir seus próprios ativos digitais a partir de uma base pré-estabelecida e compatível com outros softwares e serviços**, como carteiras de criptomoedas e corretoras.

Além da compatibilidade, cada token criado a partir do padrão ERC-20 pode ter suas próprias características e parâmetros, programados para atender às necessidades do desenvolvedor.

Por conta de tanta praticidade e flexibilidade, desde seu lançamento, a Ethereum tem atraído tanto desenvolvedores independentes como organizações e empresas. Hoje já existem mais de **500 mil tokens ERC-20 disponíveis no mercado**, relacionados a projetos variados e com diferentes propósitos.

## Principais características de um token ERC-20
Tokens ERC-20 podem possuir valor próprio e serem transferidos e recebidos como qualquer outra criptomoeda. Eles possuem mais algumas características em comum, são elas:

**Nome e símbolo:** a partir desses dois aspectos, é possível identificar e diferenciar os vários tokens dentro da rede Ethereum.
**Fornecimento:** há um fornecimento total que define quantas unidades do token serão emitidas para distribuição.
Controle de saldo: operam uma interface capaz de mapear, rever e relatar o saldo contido em um endereço específico.
**Transferências:** possuem funções que lhe permitem gerir o sistema de transferências de fundos entre endereços de forma autônoma.
Agora que você já sabe o que é ERC-20, vejamos como esses tokens funcionam.

## Como os tokens ERC-20 são criados?

O padrão ERC-20 estabelece um conjunto de parâmetros que devem ser atendidos por um contrato para que seu token seja compatível com a rede, podemos ver esse parâmetros no site [Ethereum Improvement Proposals](https://eips.ethereum.org/EIPS/eip-20) onde podemos ver todos EIPS "_Ethereum Improvement Proposals_" ou Propostas de Melhoria do Ethereum, em português. 

Esses parâmetros correspondem a funções programadas em Solidity, linguagem de programação da Ethereum. São seis funções obrigatórias e três opcionais. As funções obrigatórias são as seguintes:

**TotalSupply**: retorna o fornecimento total de tokens.
**BalanceOf**: retorna o saldo de um endereço.
**Transfer**: transfere tokens de um endereço para outro.
**TransferFrom**: também é usada para transferência, porém para permitir que um terceiro mova fundos do seu endereço. Ou seja, Alice pode autorizar Bob a transferir fundos que pertencem a ela.
**Approve**: limita a quantidade de tokens que um contrato pode retirar de um endereço.
**Allowance**: verifica se o endereço tem saldo suficiente para enviar tokens para outro endereço.
Além dessas, há também três funções que são opcionais, mas podem ser incluídas para aperfeiçoar o contrato:

**Name**: adiciona um nome legível ao token. Por exemplo: Tether, Shiba Inu, Uniswap.
**Symbol**: associa um símbolo ao token. Por exemplo: USDT, SHIB, UNI.
**‍Decimal**: define em até quantas casas decimais o token pode ser dividido.

## Como criar um token ERC-20?
Para criar um token ERC-20, é preciso escrever um contrato inteligente em Solidity, linguagem de programação da Ethereum. O contrato é um código que define as regras de funcionamento do token, como o fornecimento total, o nome, o símbolo e as funções que serão executadas.
No site da [OpenZeppelin](https://docs.openzeppelin.com/contracts/4.x/api/token/erc20), podemos ler um pouco mais sobre cada função, seus parametros e extenções para o contrato.

## Criando um token ERC-20 com Foundry

Vamos utilizar o [Contracts Wizard](https://docs.openzeppelin.com/contracts/4.x/wizard) da OpenZeppelin para criar a base do nosso contrato e implementar ele utilizando o Foundry.

### Criando contrato ERC-20 com Contracts Wizard
Selecionamos a opção ERC20, preenchemos os campos com as informações do nosso token (Nome, simbulo e premint) e selecionamos _Mintable_ e _Burnable_ para ser possivel criar e destruir nossos tokens.
![Exemplo de contrato ERC20 no contracts wizard](https://web3dev-forem-production.s3.amazonaws.com/uploads/articles/43vd2up1vn3bv6qok82e.png)

### Implementando contrato ERC-20 com 
Caso você não saiba o que é Fondry e como instalar na sua maquina e usar de uma olhada nesse tutorial [aqui](https://www.web3dev.com.br/diogoj/iniciante-em-web3-como-usar-o-foundry-para-testar-um-contrato-erc20-com-fuzzing-2pfi) que ira te ajudar a entender melhor como funciona o Foundry.
Inicie um projeto com o comando `forge init` e crie um novo arquivo chamado `MyToken.sol` dentro da pasta `src` e cole o conteudo do contrato que foi gerado pelo **Contracts Wizard**.
E como vamos utilizar as interfaces do OpenZeppelin para implementar nosso contrato, vamos instalar o pacote com o comando:
```bash
forge install openzeppelin/openzeppelin-contracts
```
Se você estiver utilizando o VSCode irá perceber que ele irá reclamar de algumas coisas, para resolver esse problema só executar esse comando:
```bash
forge remappings > remappings.txt
```
No arquivo `remappings.txt` adicione a seguinte linha: `@openzeppelin/=lib/openzeppelin-contracts/` para conseguir importar as interfaces do OpenZeppelin.

Na pasta `test` crie um arquivo chamado `MyToken.test.sol` e cole o código de testes que esta nesse [gist](https://gist.github.com/viniblack/5c6290a3352eaa62465f767e07ddfe54).

### Rodando os testes

Para rodar todos os testes do seu projeto:
```bash
forge test
```
Para rodar um teste especifico: 
```bash
forge test -m testMint
```

Para rodar os testes e gerar um relatorio de gas:
```bash
forge test --gas-report
```
![Gas Report](https://web3dev-forem-production.s3.amazonaws.com/uploads/articles/i001ub2g7deuqt9xbab4.png)

## Biografia
[ERC-20: O que é e como funciona esse tipo de token?](https://coinext.com.br/blog/erc-20)
[ERC-20: Token Standard](https://eips.ethereum.org/EIPS/eip-20)
[ERC 20](https://docs.openzeppelin.com/contracts/4.x/api/token/erc20#extensions)
[Testes foundry](https://book.getfoundry.sh/forge/tests)
[Testando ERC-20 com foundry ](https://github.com/Atarpara/openzeppeline-erc20-foundry-test)