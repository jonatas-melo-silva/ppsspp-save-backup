# ppsspp-save-backup

Backup e sincronização das saves do PPSSPP entre dispositivos Linux, usando git.

## Descrição

Repositório usado para versionar os arquivos de progresso do PPSSPP (dados de save, save states e cheats customizados), permitindo manter o mesmo progresso de jogo sincronizado entre diferentes máquinas Linux sem depender de pen drive ou nuvem comercial.

## O que é versionado

| Pasta | Conteúdo | Por quê |
| --- | --- | --- |
| `SAVEDATA/` | Save de dentro do jogo (`DATA0`, `PARAM.SFO`, etc) | É o progresso real, não dá pra recriar |
| `PPSSPP_STATE/` | Save states manuais (`.ppst`) | Pontos de continuação criados pelo usuário |
| `Cheats/` | Códigos de cheat customizados (`.ini`) | Configuração feita à mão pelo usuário |

`TEXTURES/`, `SYSTEM/`, `GAME/` e `PLUGINS/` ficam de fora, por serem cache, configuração de máquina ou asset do próprio jogo, tudo recriável pelo PPSSPP.

## Instalação

Numa máquina nova, dentro da pasta de dados do PPSSPP (a pasta que contém `SAVEDATA/`, `PPSSPP_STATE/`, `Cheats/` etc), clone o repositório com `gh`:

```bash
cd /caminho/para/a/pasta/do/psp
gh repo clone SEU_USUARIO/ppsspp-save-backup .
```

Ou com git puro:

```bash
cd /caminho/para/a/pasta/do/psp
git clone git@github.com:SEU_USUARIO/ppsspp-save-backup.git .
```

Se a pasta já tiver arquivos do PPSSPP (primeira vez configurando o backup, numa máquina que já tem save), inicialize o git nela em vez de clonar, e crie o repositório remoto direto pelo `gh`:

```bash
cd /caminho/para/a/pasta/do/psp
git init
git branch -M main
git add .
git commit -m "estrutura inicial do backup de saves"
gh repo create ppsspp-save-backup --public --source=. --remote=origin --push
```

## Uso

Depois de jogar, para subir o progresso novo:

```bash
git add .
git commit -m "update saves"
git push
```

Em outro dispositivo, para trazer o progresso mais recente:

```bash
git pull
```

Pra abrir o repositório no navegador a qualquer momento:

```bash
gh repo view --web
```

## .gitignore

```
*
!SAVEDATA/
!SAVEDATA/**
!PPSSPP_STATE/
!PPSSPP_STATE/**
!Cheats/
!Cheats/**
!README.md
!LICENSE
!.gitignore
```

## Licença

MIT. Veja [LICENSE](LICENSE).
