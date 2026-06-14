## Git — алиасы + функции

alias g='git'
alias gp='git push -u origin HEAD'
alias gcb='git checkout -b'

# первый коммит + пуш:  gship "msg"
gship() {
    git add -A && git commit -m "${1:-initial commit}" && git push -u origin HEAD
}

# быстрый коммит всего:  gsave "msg"
gsave() {
    git add -A && git commit -m "$1"
}

# pull --rebase --autostash
gsync() {
    git pull --rebase --autostash
}

# переключиться на дефолтную ветку и подтянуть:  gmain
gmain() {
    local MAIN_BRANCH
    MAIN_BRANCH=$(git remote show origin | grep "HEAD branch" | cut -d ":" -f 2 | xargs)
    if [ -z "$MAIN_BRANCH" ]; then
        echo "Ошибка: не удалось определить дефолтную ветку"
        return 1
    fi
    echo "Переключение на ветку $MAIN_BRANCH и выполнение git pull..."
    git checkout "$MAIN_BRANCH" && git pull
}
