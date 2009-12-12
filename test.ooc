import structs/[Array,ArrayList,HashMap,List]

ARG_SHORT := "-t"
ARG_LONG  := "--test"

Action: class {
    shortOption := ""
    longOption := ""
    name: String
    init: func(=name, =shortOption, =longOption) {}
}

ArgumentParser: class {
    knownArgs:  HashMap<Action>
    namespace: HashMap<String>
    actions: ArrayList<Action>
    init: func() {
        knownArgs = ArrayList<Action> new()
        namespace = HashMap<String> new()
        actions = ArrayList<Action> new()
    }

    addOption: func(shortOption, longOption, dest: String) {
        newAction := Action new(dest, shortOption, longOption)
        knownArgs put(dest, newAction)
    }

    parseArguments: func(arguments: Array<String>) {
        arg: String
        for (arg in arguments) {
            if (arg startswith("-")) {
                for (action in knownArgs) {
                    if (action shortOption == arg|| action longOption == arg) {
                        actions add(action)
                    }
                }
            }
        }
    }
}


            
main: func(args: Array<String>) {
     parser := ArgumentParser new()
     parser addOption("-t", "--test", "test")
     parser parseArguments(args)   
}

