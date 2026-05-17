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
            nodespecs[triml($1, "@")][i-2] = $i
        } else {
            rules[$1][i-2] = $i
        }
    }
}

END{
    for (rule in rules) {print rule, ":"; for (body in rules[rule]) {printf("  %s", rules[rule][body])}; print ""}
    for (nodespec in nodespecs) {print nodespec, ":"; for (attr in nodespecs[nodepec]) {printf("  %s", nodespecs[nodespec][attr])}; print ""}

    out = trim(rules["rpg-output-language"][1], "'") "::out"
    print out
    @out(rules, nodespecs)
}


func parserule(name, pattern,  ltrs) {
    #TODO: define the format of rules
    split(pattern, ltrs, "")
    rules[name] =
}

func parsenodespec(name, attrs) {
    
}

#不要だと思う
func ischoice(right,  depth) {
    for (i = 1; i <= length(right); i++) {
        switch (nth(right, i)) {
        case "(" :
            depth++; break
        case ")" :
            depth--; break
        case "|" :
            if (depth == 0)
                return 1
            break
        }
    }
    return 0
}

#不要だと思う。parseparensにする
func expandparens(right,  lp, rp, depth) {
    if ((lp = index(right, "(")) == 0)
        return right
    else {
        depth = 0
        for (i = lp+1; i <= length(right); i++) {
            switch (nth(right, i)) {
            case "(" :
                depth++
                break
            case ")" :
                if (depth == 0)
                    rp = i
                else
                    depth--
                break
            }
            if (rp) break
        }
        #TODO: split into choices!
    }
}

func parsechoices(c, result) {
    choice[++n]#TODO: 各選択肢の始端と長さを記録
    for (i = 1; i <= length(c); i++)
        switch (nth(c, i)) {
        case "(" :
            depth++; break
        case ")" :
            depth--; break
        case "|" :
            if (depth == 0) {
                choice[++n]["idx"] = i + 1
                choice[n-1]["len"] = choice[n]["idx"] - choice[n-1]["idx"] - 1
            }
        }
    for (i = 1; i <= n; i++) {
        parseparens(substr(c, choice[i]["idx"], choice[i]["len"]), flatc)
        catarys(result, flatc)
    }
}

func parseparens(p, result)
