use clooc
import structs/[Array,ArrayList]
import clooc/[Action,ArgParser,HashBag]

main: func(args: Array<String>) {
    parser := ArgumentParser new()
    
    parser addOption(ArrayList<String> new(["-a", "--a"] as String*,2), "a", Action STORE_TRUE)
    parser addOption(ArrayList<String> new(["-b", "--b"] as String*,2), "b", Action STORE_FALSE)
    parser addOption(ArrayList<String> new(["-c", "--c"] as String*,2), "c", Action STORE)
    
    result := parser parseArguments(args toArrayList())
    
    options := result get("options", HashBag)
    if (options exists("a")) { // Check if "a" is not an instance of None
        if (options get("a", Bool)) {
            "Store-True works!" println()
        }
    }     
    if (options exists("b")) {
        if (!options get("b", Bool)) {
            "Store-False works!" println()
        }
    }
    if (options exists("c")) {
        options get("c", String) println()
        "Store works!" println()
    }
  
}
