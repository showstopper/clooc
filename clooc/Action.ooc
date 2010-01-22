use clooc
import structs/[ArrayList]
import HashBag

Action: class {
    myArg, name: String
    STORE_TRUE: static Int = 111
    STORE_FALSE: static Int = 222
    STORE: static Int = 333
    actionType: Int
    getFunc: Func(String, ArrayList<String>, ArrayList<String>, Int, Int, HashBag) 
    matchFunc: Func(String, String) -> Bool
    init: func(=myArg, =name, =actionType, =getFunc, =matchFunc) {}
    
    getValue: func(args, rargs: ArrayList<String>, pos: Int, hBag: HashBag) {
        getFunc(name, args, rargs, pos, actionType, hBag)
    }

    matches: func(arg: String) -> Bool {
        matchFunc(myArg, arg)
    }
}

FuncSpace: class {
    init: func {}
    matchSimple: static func(pattern, arg: String) -> Bool {
        pattern == arg
    }
    
    matchPair: static func(sep: Char, pattern, arg: String) -> Bool {
        pos := arg indexOf(sep)
        if (pos != -1) {
            return pattern == arg[0..arg indexOf(sep)]
        }
        return false
    }

    matchLong: static func(pattern, arg: String) -> Bool {
        return matchPair('=', pattern, arg)
    }

    getShortValue: static func(name: String, args, rargs: ArrayList<String>, pos, actionType: Int, hBag: HashBag) {
        if (actionType == Action STORE_TRUE) {hBag put(name, true);return}
        else if (actionType == Action STORE_FALSE) {hBag put(name, false);return}
        else if (actionType == Action STORE) {
            if (args size() - 1  >= pos+1) { 
                result := args get(pos+1)
                rargs removeAt(pos+1)
                hBag put(name, result)
                return 
            } 
            "Error: missing argument!" println() // TODO: Add *real* error handling
            hBag put(name, None new())
        } else {
            "Unkown actionType type!" println()
            hBag put(name, None new())
        }
        
    }

    getLongValue: static func(name: String, args, rargs: ArrayList<String>, pos, actionType: Int, hBag: HashBag) {
        if (actionType == Action STORE_TRUE) {hBag put(name, true)}
        else if (actionType == Action STORE_FALSE) {hBag put(name, false)}        
        else if (actionType == Action STORE) {
            arg := args get(pos)
            if (arg indexOf('=') != -1) {
                hBag put(name, arg substring(arg indexOf('=')+1))
                return
            }
            hBag put(name, None new())
        } else {
            "Unkown actionType type!" println()
            hBag put(name, None new()) 
        }
    } 
}


