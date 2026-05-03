@namespace "kuin"

func out(rules, nodespecs) {
    for (s in nodespecs)
        print toclass(s)
    for (r in rules)
        print tofunc(r)
}

func funcname(name,  result) {
    for (i = 1; i <= length(name); i++) {
        if (nth(name, i) == "-") {
            result = result toupper(nth(name, ++i))
        } else {
            result = result nth(name, i)
        }
    }
    return result
}
func classname(name,  result) {
    result = toupper(nth(name, 1))
    for (i = 2; i <= length(name); i++) {
        if (nth(name, i) == "-") {
            result = result toupper(nth(name, ++i))
        } else {
            result = result nth(name, i)
        }
    }
    return result
}

func toclass(name, properties,  result) {
    result = "class " classname(name) "\n"

}
