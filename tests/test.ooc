use clooc
import structs/[Array,ArrayList,HashMap]
import clooc/[Action,ArgParser,Utils]
import clooc/Bag

main: func(args: Array<String>) {
    parser := ArgumentParser new()
    parser addOption(ArrayList<String> new(["-a", "--a"],2), "a", Action STORE_TRUE)
    parser addOption(ArrayList<String> new(["-b", "--b"],2), "b", Action STORE_FALSE)
    parser addOption(ArrayList<String> new(["-c", "--c"],2), "c", Action STORE)
    result := parser parseArguments(args toArrayList())
    options := result get(0, HashMap<Cell<Pointer>>)
    if (options["a"] T != None) {
        if (options["a"] val) {
            "Store-True works!" println()
        }
    }
    if (options["b"] T != None) {
        if (!options["b"] val) {
            "Store-False works!" println()
        }
    }
    if (options["c"] T != None) {
        (options["c"] val as String) println()
        //printf("%d\n", (options["c"] val  as String) length())
        "Store works!" println()
    }
}
