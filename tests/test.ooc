use clooc
import structs/[Array,ArrayList,HashMap]
import clooc/[Action,ArgParser,Utils]
import clooc/HashBag

main: func(args: Array<String>) {
    parser := ArgumentParser new()
    parser addOption(ArrayList<String> new(["-a", "--a"] as String*,2), "a", Action STORE_TRUE)
    parser addOption(ArrayList<String> new(["-b", "--b"] as String*,2), "b", Action STORE_FALSE)
    parser addOption(ArrayList<String> new(["-c", "--c"] as String*,2), "c", Action STORE)
    result := parser parseArguments(args toArrayList())
    options := result get("options", HashMap<Cell<Pointer>>)
    if (!options["a"] T instanceOf(None)) {
        if (options["a"] val) {
            "Store-True works!" println()
        }
    }
    if (!options["b"] T instanceOf(None)) {
        if (!options["b"] val) {
            "Store-False works!" println()
        }
    }
    if (!options["c"] T instanceOf(None)) {
        (options["c"] val as String) println()
        //printf("%d\n", (options["c"] val  as String) length())
        "Store works!" println()
    }
}
