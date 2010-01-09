import structs/[ArrayList,HashMap]

ParsingResult: cover {
    options: HashMap<Cell<Pointer>>
    arguments: ArrayList<String>
    new: static func(.options, .arguments) -> This {
        this: This
        this options = options
        this arguments = arguments
        return this
    }
}

