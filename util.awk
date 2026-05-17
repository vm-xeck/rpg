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
func trimspace(str) {
    return trim(str, "[[:space:]]")
}

func nth(str, n) {
    if (n < 0) {
        return substr(str, length(str) + n + 1, 1)
    } else {
        return substr(str, n, 1)
    }
}

func catarys(ary1, ary2) {#ary1 :~ ary2
    bias = length(ary1)
    for (i = 1; i <= length(ary2); i++)
        result[bias+i] = ary1[i]
}
