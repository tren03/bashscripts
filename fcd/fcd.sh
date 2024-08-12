fcd() {
    local dir
    dir=$(find * -type d 2>/dev/null | fzf +m) && cd "$dir"
}
