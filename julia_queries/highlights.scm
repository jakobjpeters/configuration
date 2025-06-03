
; ((string_literal) @comment.block.documentation
;   .
;   [
;     (abstract_definition)
;     (assignment)
;     (const_statement)
;     (function_definition)
;     (macro_definition)
;     (module_definition)
;     (struct_definition)
;   ])

; attribute - Class attributes, HTML tag attributes

; type - Types
;     builtin - Primitive types provided by the language (int, usize)
;     parameter - Generic type parameters (T)
;     enum
;         variant
(type_head
  [
    (identifier) @type
    (binary_expression (identifier) @type)
  ])
(unary_typed_expression (identifier) @type)
(typed_expression (identifier) @type)
(where_expression
  [
    (identifier) @type
    (binary_expression (identifier) @type)
    (curly_expression (identifier) @type)
    (curly_expression
      [
        (identifier) @type
        (binary_expression (identifier) @type)
      ])
  ])
(parametrized_type_expression
  [
    (identifier) @type
    (curly_expression
      [
        (identifier) @type.parameter
        (unary_expression (identifier) @type)
      ])
  ])
; TODO: use `Base`?
; println(join(map(name -> "\"$name\"", filter(name -> getproperty(Core, name) isa Type, names(Core))), ' '))
((identifier) @type.builtin
  (#any-of? @type.builtin
    "AbstractArray" "AbstractChar" "AbstractFloat" "AbstractString" "Any" "ArgumentError" "Array" "AssertionError" "AtomicMemory" "AtomicMemoryRef" "Bool" "BoundsError" "Char" "ConcurrencyViolationError" "Cvoid" "DataType" "DenseArray" "DivideError" "DomainError" "ErrorException" "Exception" "Expr" "Float16" "Float32" "Float64" "Function" "GenericMemory" "GenericMemoryRef" "GlobalRef" "IO" "InexactError" "InitError" "Int" "Int128" "Int16" "Int32" "Int64" "Int8" "Integer" "InterruptException" "LineNumberNode" "LoadError" "Memory" "MemoryRef" "Method" "MethodError" "Module" "NTuple" "NamedTuple" "Nothing" "Number" "OutOfMemoryError" "OverflowError" "Pair" "Ptr" "QuoteNode" "ReadOnlyMemoryError" "Real" "Ref" "SegmentationFault" "Signed" "StackOverflowError" "String" "Symbol" "Task" "Tuple" "Type" "TypeError" "TypeVar" "UInt" "UInt128" "UInt16" "UInt32" "UInt64" "UInt8" "UndefInitializer" "UndefKeywordError" "UndefRefError" "UndefVarError" "Union" "UnionAll" "Unsigned" "VecElement" "WeakRef"))

; constructor

; constant (TODO: constant.other.placeholder for %v)
;     builtin Special constants provided by the language (true, false, nil etc)
;         boolean
;     character
;         escape
;     numeric (numbers)
;         integer
;         float
; TODO: use `Base`?
; println(join(map(name -> "\"$name\"", filter(name -> isconst(Core, name) && !(getproperty(Core, name) isa Union{Function, Module, Type} || name == :Vararg), names(Core))), ' '))
((identifier) @constant.builtin
  (#any-of? @constant.builtin "nothing" "undef"))

; comment - Code comments
;     line - Single line comments (//)
;     block - Block comments (e.g. (/* */)
;         documentation - Documentation comments (e.g. /// in Rust)
(line_comment) @comment.line
(block_comment) @comment.block
; must match before `(string_literal) @string`
((string_literal) @comment.block.documentation
  .
  [
    (abstract_definition)
    (assignment)
    (const_statement)
    (function_definition)
    (identifier)
    (macro_definition)
    (module_definition)
    (primitive_definition)
    (struct_definition)
  ])

; string (TODO: string.quoted.{single, double}, string.raw/.unquoted)?
;     regexp - Regular expressions
;     special
;         path
;         url
;         symbol - Erlang/Elixir atoms, Ruby symbols, Clojure keywords
(string_literal) @string
(escape_sequence) @string.escape
(command_literal) @string.special
(quote_expression
  ":" @string.special.symbol
  [
    (identifier)
    (operator)
  ] @string.special.symbol)

; variable - Variables
;     builtin - Reserved language variables (self, this, super, etc.)
;     parameter - Function parameters
;     other
;         member - Fields of composite data types (e.g. structs, unions)
;             private - Private fields that use a unique syntax (currently just ECMAScript-based languages)
; (identifier) @variable
; (field_expression
;   (identifier) @variable.member .)

; label

; punctuation
;     delimiter - Commas, colons
;     bracket - Parentheses, angle brackets, etc.
;     special - String interpolation brackets.

; keyword
;     control
;         conditional - if, else
;         repeat - for, while, loop
;         import - import, export
;         return
;         exception
;     operator - or, in
;     directive - Preprocessor directives (#if in C)
;     function - fn, func
;     storage - Keywords describing how things are stored
;         type - The type of something, class, function, var, let, etc.
;         modifier - Storage modifiers like static, mut, const, ref, etc.

; operator - ||, +=, >

; function
;     builtin
;     method
;         private - Private methods that use a unique syntax (currently just ECMAScript-based languages)
;     macro
;     special (preprocessor in C)

; tag - Tags (e.g. <body> in HTML)
;     builtin

; namespace

; special

; markup
;     heading
;         marker
;         1, 2, 3, 4, 5, 6 - heading text for h1 through h6
;     list
;         unnumbered
;         numbered
;         checked
;         unchecked
;     bold
;     italic
;     strikethrough
;     link
;         url - URLs pointed to by links
;         label - non-URL link references
;         text - URL and image descriptions in links
;     quote
;     raw
;         inline
;         block
