use clooc
import clooc/Argparser
import structs/[Array,ArrayList,HashMap]

toArrayList: func<T>(array: Array<T>) -> ArrayList<T> {
    toRet := ArrayList<T> new()
    for (item: T  in array) {
        toRet add(item)
    }
    return toRet
}

main: func(args: Array<String>) {
    parser := ArgumentParser new()
    parser addOption("-a", "--aa", "a", Action STORE_TRUE)
    parser addOption("-b", "--bb", "b", Action STORE_FALSE)
    parser addOption("-c", "--cc", "c", Action STORE)
    result := parser parseArguments(toArrayList(args))
    result options get("a") println()
    result options get("b") println()
    result options get("c") println()
    for (arg in result arguments) {
        arg println()
    }
}
