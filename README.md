# dotfiles

Модульная настройка Debian/Ubuntu — одной командой.

## Быстрый старт

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Hynwell/dotfiles/main/bootstrap.sh)"
```

С Docker:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Hynwell/dotfiles/main/bootstrap.sh)" -- --with-docker
```

Только shell и базовые утилиты:
```bash
bash -c "$(curl -fsSL ...bootstrap.sh)" -- --minimal
```

---

## Что устанавливается

### Базовый профиль (`--all`, по умолчанию)

| Инструмент | Вместо | Зачем |
|-----------|--------|-------|
| **zsh** + Starship | bash + p10k | современный shell, быстрый промпт |
| **eza** | ls | цвета, иконки, git-статус, дерево |
| **bat** | cat | просмотр файлов с подсветкой синтаксиса |
| **fd** | find | простой поиск файлов |
| **ripgrep** (rg) | grep | быстрый поиск по коду |
| **fzf** | — | fuzzy-поиск: Ctrl+R история, Ctrl+T файлы |
| **zoxide** (z) | cd | умный переход, запоминает пути |
| **btop** | top/gtop | монитор CPU/RAM/сети |
| **tldr** | man | краткие примеры по командам |
| **delta** | diff | красивые git diff |
| **tmux** | screen | мультиплексор терминала |
| **just** | make | запуск задач (justfile) |

### Опциональные модули

| Флаг | Что ставит |
|------|-----------|
| `--with-docker` | docker-ce + compose plugin, добавляет юзера в группу docker |
| `--with-nvim` | nvim + плагины |
| `--minimal` | только base + shell + cli (без tmux/git/just) |

---

## Структура репозитория

```
dotfiles/
├── bootstrap.sh         # точка входа из сети (curl | bash)
├── install.sh           # локальный оркестратор, принимает флаги
├── lib/
│   ├── common.sh        # хелперы: логи, has_cmd, symlink
│   └── apt.sh           # обёртки над apt: идемпотентная установка
├── modules/
│   ├── 10-base.sh       # базовые пакеты системы
│   ├── 20-shell.sh      # zsh + starship + плагины
│   ├── 30-cli.sh        # современные CLI-утилиты
│   ├── 40-tmux.sh       # tmux
│   ├── 50-git.sh        # git + delta
│   ├── 60-just.sh       # just
│   └── 90-docker.sh     # docker (опц.)
└── config/
    ├── zsh/             # → ~/.zshrc + ~/.config/zsh/*
    ├── starship/        # → ~/.config/starship.toml
    ├── git/             # → ~/.gitconfig
    ├── tmux/            # → ~/.tmux.conf
    └── just/            # justfiles для docker и git
```

Все конфиги раскладываются **симлинками**: редактируешь файл в репо — изменение сразу в системе.

---

## Локальный запуск

```bash
# Запустить всё
./install.sh

# Только один модуль
./install.sh --module cli

# Запустить без смены shell
./install.sh --no-chsh
```

---

Полный список алиасов: команда `alias`. Справка по инструментам: `cheat`.


