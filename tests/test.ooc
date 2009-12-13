import ../source/Argparser
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
    parsedArguments := parser parseArguments(toArrayList(args))
    parsedArguments get("a") println()
    parsedArguments get("b") println()
    parsedArguments get("c") println()
}