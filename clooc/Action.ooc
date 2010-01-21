use clooc
import structs/[ArrayList]
import HashBag

Action: class {
    myArg, name: String
    STORE_TRUE: static Int = 111
    STORE_FALSE: static Int = 222
    STORE: static Int = 333
    action: Int
    getFunc: Func 
    matchFunc: Func
    init: func(=myArg, =name, =action, =getFunc, =matchFunc) {}

    getValue: func(args, rargs: ArrayList<String>, pos: Int, hBag: HashBag) {
        getFunc(name, args, rargs, pos, action, hBag)
    }
    
    matches: func(arg: String) -> Bool {
        matchFunc(myArg, arg)
    }
    //matches: abstract func(pattern: String) -> Bool
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
    getShortValue: static func(name: String, args, rargs: ArrayList<String>, pos, action: Int, hBag: HashBag) {
        if (action == Action STORE_TRUE) {hBag put(name, true);return}
        else if (action == Action STORE_FALSE) {hBag put(name, false);return}
        else if (action == Action STORE) {
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

    getLongValue: static func(name: String, args, rargs: ArrayList<String>, pos, action: Int, hBag: HashBag) {
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
   

}

/*
            
LongOptionPair: class extends LongOption {
    init: func(=myArg, =name, =action) {}
    getValue: func(args, rargs: ArrayList<String>, pos: Int, hBag: HashBag) {
        super getValue(args, rargs, pos, hBag)
        pair := hBag get(name, String) 
        index := pair indexOf('=')
        if (index != -1) {
            hBag put(name, pair substring(pair indexOf('=')+1))
            return
        }
    }
    matches: func(pattern: String) -> Bool {
        matchPairArg(pattern, myArg)          
    }
}

ShortOptionPair: class extends ShortOption {
    init: func(=myArg, =name, =action) {}
    getValue: func(args, rargs: ArrayList<String>, pos: Int, hBag: HashBag) {
        super getValue(args, rargs, pos, hBag)
        pair := hBag get(name, String)
        index := pair indexOf('=')
        if (index != -1) {
            hBag put(name, pair substring(index+1))
            return
        }
        hBag put(name, pair)
    }
    matches: func(pattern: String) -> Bool {
        matchPairArg(pattern, myArg)
    }
}

matchSimple: inline func(pattern, myArg: String) -> Bool {
    pattern == myArg
}

matchPairArg: func(pattern: String, myArg: String) -> Bool {
    if (pattern indexOf('=') != -1) {
        r



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
        matchSimple(pattern, myArg)
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
        matchSimple(pattern, myArg)
    }
}

LongOptionPair: class extends LongOption {
    init: func(=myArg, =name, =action) {}
    getValue: func(args, rargs: ArrayList<String>, pos: Int, hBag: HashBag) {
        super getValue(args, rargs, pos, hBag)
        pair := hBag get(name, String) 
        index := pair indexOf('=')
        if (index != -1) {
            hBag put(name, pair substring(pair indexOf('=')+1))
            return
        }
    }
    matches: func(pattern: String) -> Bool {
        matchPairArg(pattern, myArg)          
    }
}

ShortOptionPair: class extends ShortOption {
    init: func(=myArg, =name, =action) {}
    getValue: func(args, rargs: ArrayList<String>, pos: Int, hBag: HashBag) {
        super getValue(args, rargs, pos, hBag)
        pair := hBag get(name, String)
        index := pair indexOf('=')
        if (index != -1) {
            hBag put(name, pair substring(index+1))
            return
        }
        hBag put(name, pair)
    }
    matches: func(pattern: String) -> Bool {
        matchPairArg(pattern, myArg)
    }
}

matchSimple: inline func(pattern, myArg: String) -> Bool {
    pattern == myArg
}

matchPairArg: func(pattern: String, myArg: String) -> Bool {
    if (pattern indexOf('=') != -1) {
        return myArg == pattern[0..pattern indexOf('=')]
    }
}
*/
