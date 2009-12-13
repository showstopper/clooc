use clooc
import structs/[Array,ArrayList,HashMap]
import clooc/Argparser

main: func(args: Array<String>) {
    parser := ArgumentParser new()
    parser addOption("-a", "--aa", "a", Action STORE_TRUE)
    parser addOption("-b", "--bb", "b", Action STORE_FALSE)
    parser addOption("-c", "--cc", "c", Action STORE)
    result := parser parseArguments(args toArrayList())
    result options get("a") println()
    result options get("b") println()
    result options get("c") println()
    for (arg in result arguments) {
        arg println()
    }
}
