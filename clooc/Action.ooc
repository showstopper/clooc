use clooc
import structs/[ArrayList]
import HashBag

Action: abstract class {
    myArg, name: String
    STORE_TRUE: static Int = 111
    STORE_FALSE: static Int = 222
    STORE: static Int = 333
    action: Int
    getValue: abstract func(args, rargs: ArrayList<String>, pos: Int, hBag: HashBag) 
    matches: abstract func(pattern: String) -> Bool
}

ShortOption: class extends Action {
    init: func(=myArg, =name, =action) {}
    getValue: func(args, rargs: ArrayList<String>, pos: Int, hBag: HashBag) {
        if (action == STORE_TRUE) {hBag put(name, true);return}
        else if (action == STORE_FALSE) {hBag put(name, false);return}
        else if (action == STORE) {
            if (args size() - 1  >= pos+1) { 
                result := args get(pos+1)
                rargs removeAt(pos+1)
                hBag put(name, result)
                return 
            } 
            "Error: missing argument!" println() // TODO: Add *real* error handling
            hBag put(name, None new())
        } else {
            "Unkown action type!" println()
            hBag put(name, None new())
        }
    }
    
    matches: func(pattern: String) -> Bool {
        myArg == pattern
    }
}

LongOption: class extends Action {
    init: func(=myArg, =name, =action) {}
    getValue: func(args, rargs: ArrayList<String>, pos: Int, hBag: HashBag) {
        if (action == STORE_TRUE) {hBag put(name, true)}
        else if (action == STORE_FALSE) {hBag put(name, false)}        
        else if (action == STORE) {
            arg := args get(pos)
            if (arg indexOf('=') != -1) {
                hBag put(name, arg substring(arg indexOf('=')+1))
                return
            }
            hBag put(name, None new())
        } else {
            "Unkown action type!" println()
            hBag put(name, None new()) 
        }
    
    } 
    matches: func(pattern: String) -> Bool {
        if (pattern indexOf('=') != -1) {
            return myArg == pattern[0..pattern indexOf('0')]
        }
        return myArg == pattern
    }
}

