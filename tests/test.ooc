use clooc
import structs/[Array,ArrayList,HashMap]
import clooc/[Action,ArgParser,Utils]

main: func(args: Array<String>) {
    parser := ArgumentParser new()
    parser addOption(ArrayList<String> new(["-a", "--a"],2), "a", Action STORE_TRUE)
    parser addOption(ArrayList<String> new(["-b", "--b"],2), "b", Action STORE_FALSE)
    parser addOption(ArrayList<String> new(["-c", "--c"],2), "c", Action STORE)
    result := parser parseArguments(args toArrayList())
    options := result options
    if (options["a"] val) {
        "Store-True works!" println()
    }
    if (options["b"] val == false) {
        "Store-False works!" println()
    }
    if (options["c"] val) {
        options["c"] val as String println()
        "Store works!"
    }
}
