//use clooc
import structs/[Array,ArrayList]
import Action
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
        action: Action
        for (patt in patterns) {
            if (patt startsWith("--")) {
                "long-option" println()
                action = Action new(patt, dest, action, FuncSpace getLongValue as Func, FuncSpace matchLong as Func)
                actions add(action)
                //LongOption new(patt, dest, action))
            } else if (patt startsWith("-")) {
                "short-option" println()
                action = Action new(patt, dest, action, FuncSpace getShortValue as Func, FuncSpace matchSimple as Func)
                actions add(action)
                //actions add (ShortOption new(patt, dest, action))
                
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
                if (action matches(arg)) {
                    pos := args indexOf(arg)
                    action getValue(args, rargs, pos, namespace)
                }
            }
        }
        toRet := HashBag new(2)
        toRet put("options", namespace).put("arguments", rargs)
        return toRet
    }

    _initDefaultNamespace: func {
        for (action in actions) {
            namespace put(action name, None new())
        }
    } 
}
