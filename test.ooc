import structs/[Array,ArrayList,HashMap,List]


Action: class {
    shortOption := ""
    longOption := ""
    name: String
    action: String
    init: func(=name, =shortOption, =longOption, =action) {}
}

Cell: class<t> {init: func(){}}

ArgumentParser: class {
    knownArgs := HashMap<Action> new()
    namespace := HashMap<String> new()
    actions := ArrayList<Action> new()
    
    init: func() {}
    
    addOption: func(shortOption, longOption, dest, action: String) {
        newAction := Action new(dest, shortOption, longOption, action)
        knownArgs put(dest, newAction)
    }

    parseArguments: func(arguments: Array<String>) -> HashMap<String>{
        _initDefaultNamespace()
        for (arg in arguments) {
            if (arg startsWith("-")) {
                for (action in knownArgs) {
                    if (action shortOption == arg|| action longOption == arg) {
                        actions add(action)
                    }
                }
            }
        
        }
        _parseActions(actions)
        return namespace
        
    }
    _parseActions: func(actions: ArrayList<Action>) {
        for (action in actions) {
            
            match action action {
                case "store_true" => namespace put(action name, "1")
                case "store_false" => namespace put(action name, "0")
                    
            }
        }
         
    }
    
    _initDefaultNamespace: func() {
        for (name in knownArgs keys) {
            namespace put(name, "default")
        }
    }           
}
            
main: func(args: Array<String>) {
     parser := ArgumentParser new()
     parser addOption("-t", "--test", "test", "store_true")
     parser addOption("-f", "--fault", "fault", "store_false")
     b := parser parseArguments(args)   
     b get("test") println()
     b get("fault") println()
     
}

