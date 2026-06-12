set shell := ["bash", "-uc"]

# показать список команд
default:
    @just --list

# первый коммит и пуш нового репо:  just ship "msg"
ship msg="initial commit":
    git add -A && git commit -m "{{msg}}" && git push -u origin HEAD

# быстрый коммит всего:  just save "msg"
save msg:
    git add -A && git commit -m "{{msg}}"

# подтянуть с ребейзом
sync:
    git pull --rebase --autostash

# короткий граф коммитов
log:
    git log --oneline --graph --decorate -20
