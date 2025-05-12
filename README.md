# Busca da Naninha

> Jogo de aventura em Prolog onde você explora cômodos, coleta objetos e vence desafios.

## 📖 Descrição
"Busca da Naninha" é um pequeno jogo de lógica implementado em Prolog. O jogador inicia em um cômodo da casa, pode se mover entre cômodos conectados, pegar objetos e interagir com eles para desbloquear novas áreas até encontrar a naninha.

## 🚀 Funcionalidades
- Navegação entre cômodos (porta trancada/exterior só com luz e chave).  
- Coleta de objetos: lanterna, gerador, chave, etc.  
- Interação com objetos para desbloqueio de rotas (ligar lanternas, destrancar portas).  
- Condições de derrota/impasse ao tentar ações inadequadas.

## ⚙️ Pré-requisitos
- [SWI-Prolog](https://www.swi-prolog.org/) instalado (ou qualquer interpretador compatível).

## 🛠️ Como Rodar
1. Abra o terminal  
2. Carregue o arquivo principal:
   ```prolog
   ?- [ 'Agentes lógicos Naninha Polog.pl' ].
   ```
3. Inicie o jogo:
   ```prolog
   ?- loop.
   ```

## 🎲 Como Jogar
- Comandos principais:
  - `veja.` — lista objetos e caminhos no cômodo atual.  
  - `goto(Cômodo).` — tenta mover-se para o cômodo indicado.  
  - `pegue(Objeto).` — coleta o objeto, se disponível.  
  - `interaja(Objeto).` — interage (liga, destranca) com o objeto em posse ou no local.  
  - `fim.` — encerra o jogo.

## 🗂️ Estrutura de Arquivos
```
IA3/
 ├ Agentes lógicos Naninha Polog.pl   # lógica do jogo
 └ README.md                          # documentação
