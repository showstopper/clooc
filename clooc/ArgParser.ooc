use clooc
import structs/[Array,ArrayList]
import clooc/[Action,Utils]
import HashBag

ArgumentParser: class {
    actions := ArrayList<Action> new()
    namespace := HashBag new()
    //<Cell<Pointer>> new()
    init: func() {}
    addOption: func(patterns: ArrayList<String>, dest: String, action: Int) {
    /*
    addOption:
    Connects a list of argument-string to a target name (where the parsed options shall be stored)
    @patterns: List of argument-string 
    @dest: Name under which the option should be saved
    @action: Specifies what should be done with the argument (e.g. acting as bool-flag)
    @return: Nothing
    */
        for (patt in patterns) {
            if (patt startsWith("--")) {
                "long-option" println()
                actions add(LongOption new(patt, dest, action))
            } else if (patt startsWith("-")) {
                "short-option" println()
                actions add (ShortOption new(patt, dest, action))
            }
        }
    }
    parseArguments: func(args: ArrayList<String>) -> HashBag {
    /*
    parseArguments:
    Reads all arguments and fills the namespace with the values parsed by
    the several action-classes.
    @args: The arguments passed to main
    @return: Structure containing all options and arguments
    
    */   
        _initDefaultNamespace()
        rargs := args clone()
        rargs removeAt(0) // Remove (uninteresting) program-name
        for (arg in args) {             
            for (action in actions) {
                if (action myArg == arg) {
                    pos := args indexOf(arg)
                    val := action getValue(args, rargs, pos)
                    namespace[action name] = val
                }
            }
        }
        toRet := HashBag new(2)
        toRet put("options", namespace).put("arguments", rargs)
        return toRet
        //return ParsingResult new(namespace, rargs)
    }

    _initDefaultNamespace: func {
        for (action in actions) {
            namespace[action name] = Cell<None> new(None new())
        }
    } 
}

