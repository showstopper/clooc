import structs/[Array,ArrayList,HashMap,List]

Action: class {
    
    STORE: static Int = 0
    STORE_TRUE: static Int = 1
    STORE_FALSE: static Int = 2
    
    shortOption := ""
    longOption := ""
    name: String
    value := "default"
    action: Int
    init: func(=name, =shortOption, =longOption, =action) {}
    setVal: func(=value){}
    getValue: func() -> String {
        match action {
            case STORE_TRUE => "1"
            case STORE_FALSE => "0"
            case STORE => value
        }
    }
}
Cell: class<t> {init: func(){}}

ArgumentParser: class {
    knownArgs := HashMap<Action> new()
    namespace := HashMap<String> new()
    actions := ArrayList<Action> new()
    
    init: func() {}
    
    addOption: func(shortOption, longOption, dest: String,  action: Int) {
        newAction := Action new(dest, shortOption, longOption, action)
        knownArgs put(dest, newAction)
    }

    _parseLongOption: func(arg: String) {
        for (action in knownArgs) {
            if (arg contains('=')) {
                if (action longOption == arg[0..(arg indexOf('='))]) {
                    action setVal(_getLongVal(arg))
                    actions add(action)
                }
            } else if (action longOption == arg) {
                actions add(action)
            }
        }
    }

    _parseShortOption: func(arg: String, args: ArrayList<String>)   {
        for (action in knownArgs) {
            if (action shortOption == arg) {
                if (action action == Action STORE) {
                    action setVal(_getShortVal(arg, args))
                    
                }
                actions add(action)
            }
        }
    }
    
    _getLongVal: func(arg: String) -> String {
        arg substring(arg indexOf('=')+1)
    }

    _getShortVal: func(arg: String, args: ArrayList<String>) -> String {
        pos := args indexOf(arg)
        result := ""
        if (args size() >= pos+1) { 
            result = args get(pos+1)
        }      
        return result
    }

    parseArguments: func(arguments: ArrayList<String>) -> HashMap<String>{
        _initDefaultNamespace()
        rargs := arguments clone()
        for (arg in rargs) {
            if (arg startsWith("-")) {
                if (arg startsWith("--")) {
                    _parseLongOption(arg)
                } else {
                    _parseShortOption(arg, arguments)
                }
            }        
        }
        _parseActions(actions)
        return namespace
    } 
    
    _parseActions: func(actions: ArrayList<Action>) {
        for (action in actions) {
           namespace put(action name, action getValue()) 
        }
    }
    
    _initDefaultNamespace: func() {
        for (name in knownArgs keys) {
            namespace put(name, "default")
        }
    }           
}
            


