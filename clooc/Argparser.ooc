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

ParsingResult: cover {
    options: HashMap<String>
    arguments: ArrayList<String>
    new: static func(.options, .arguments) -> This {
        this: This
        this options = options
        this arguments = arguments
        return this
    }
}

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

    _parseShortOption: func(arg: String, args: ArrayList<String>, rargs: ArrayList<String>)   {
        for (action in knownArgs) {
            if (action shortOption == arg) {
                if (action action == Action STORE) {
                    action setVal(_getShortVal(arg, args, rargs))
                }
                actions add(action)
            }
        }
    }
    
    _getLongVal: func(arg: String) -> String {
        arg substring(arg indexOf('=')+1)
    }

    _getShortVal: func(arg: String, args, rargs: ArrayList<String>) -> String {
        pos := args indexOf(arg)
        result := "default"
        if (args size() - 1  >= pos+1) { 
            result = args get(pos+1)
            rargs removeAt(pos+1)
        }      
        return result
    }

    parseArguments: func(arguments: ArrayList<String>) -> ParsingResult{
        _initDefaultNamespace()
        rargs := arguments clone()
        rargs removeAt(0) // get rid of program name
        for (arg in rargs) {
            if (arg startsWith("-")) {
                if (arg startsWith("--")) {
                    _parseLongOption(arg)
                    rargs remove(arg)
                } else {
                    _parseShortOption(arg, arguments, rargs)
                    rargs remove(arg)
                }
            }        
        }
        _parseActions(actions)
        return ParsingResult new(namespace, rargs)
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
            


