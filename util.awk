func trim(str, target) {
    gsub(sprintf("^(%s)+", target), "", str)
    gsub(sprintf("(%s)+$", target), "", str)
    return str
}

func nth(str, n) {
    if (n < 0) {
        return substr(str, length(str) + n + 1, 1)
    } else {
        return substr(str, n, 1)
    }
}
