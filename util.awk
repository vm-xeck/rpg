func triml(str, target) {
    gsub(sprintf("^(%s)+", target), "", str)
    return str
}
func trimr(str, target) {
    gsub(sprintf("(%s)+$", target), "", str)
    return str
}
func trim(str, target) {
    return triml(trimr(str, target), target)
}

func nth(str, n) {
    if (n < 0) {
        return substr(str, length(str) + n + 1, 1)
    } else {
        return substr(str, n, 1)
    }
}
