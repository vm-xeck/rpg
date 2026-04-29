#!/bin/awk -f

@include "util.awk"
@include "languages/kuin.awk"
@include "languages/ocaml.awk"

BEGIN{
    RS = ";"
    rules["rpg-output-language"][1] = "kuin"
}

{if ($1 ~ /^#/) {next}}

{
    if ($2 != ":=") {print "Syntax error:", "rule", NR > "/dev/stderr"; exit 1}

    for (i = 3; i <= NF; i++) {
        if (nth($1, 1) == "@") {#TODO: ここでもうちょいちゃんと構造を表現したいかも
            classes[triml($1, "@")][i-2] = $i
        } else {
            rules[$1][i-2] = $i
        }
    }
}

END{
    for (rule in rules) {print rule, ":"; for (body in rules[rule]) {printf("  %s", rules[rule][body])}; print ""}
    for (class in classes) {print class, ":"; for (def in classes[class]) {printf("  %s", classes[class][def])}; print ""}

    out = trim(rules["rpg-output-language"][1], "'") "::out"
    print out
    @out(rules, classes)
}
