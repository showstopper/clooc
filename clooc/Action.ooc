use clooc
import structs/[ArrayList,HashMap]
import clooc/Utils

Action: abstract class {
    myArg, name: String
    STORE_TRUE: static Int = 111
    STORE_FALSE: static Int = 222
    STORE: static Int = 333
    action: Int
    getValue: abstract func(args, rargs: ArrayList<String>, pos: Int) -> Cell<Pointer>
    matches: abstract func(pattern: String) -> Bool
}

ShortOption: class extends Action {
    init: func(=myArg, =name, =action) {}
    getValue: func(args, rargs: ArrayList<String>, pos: Int) -> Cell<Pointer> {
        if (action == STORE_TRUE) {return Cell<Bool> new(true)}
        else if (action == STORE_FALSE) {return Cell<Bool> new(false)}
        else if (action == STORE) {
            if (args size() - 1  >= pos+1) { 
                result := args get(pos+1)
                rargs removeAt(pos+1)
                result println()
                return Cell<String> new(result)
            } 
            return Cell<Pointer> new(null)
        } else {
            "Unkown action type!" println()
            return Cell<Pointer> new(null)
        }
    }
    
    matches: func(pattern: String) -> Bool {
        myArg == pattern
    }
}

LongOption: class extends Action {
    init: func(=myArg, =name, =action) {}
    getValue: func(args, rargs: ArrayList<String>, pos: Int) -> Cell<Pointer> {
        if (action == STORE_TRUE) {return Cell<Bool> new(true)}
        else if (action == STORE_FALSE) {return Cell<Bool> new(false)}
        else if (action == STORE) {
            arg := args get(pos)
            if (arg indexOf('=') != -1) {
                return Cell<String> new(arg substring(arg indexOf('=')+1))
            }
            return Cell<Pointer> new(null)
        } else {
            "Unkown action type!" println()
            return Cell<Pointer> new (null)
        }
    }
    matches: func(pattern: String) -> Bool {
        if (pattern indexOf('=') != -1) {
            return myArg == pattern[0..pattern indexOf('0')]
        }
        return myArg == pattern
    }
}

