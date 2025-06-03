
; combination

(macrocall_expression
  (macro_identifier "@" (identifier) @function.macro
    (#eq? @function.macro "enum"))
  (macro_argument_list
    [
      (identifier) @type.enum
      (typed_expression (identifier) @type.enum "::" (_))
    ]
    [
      (identifier) @type.enum.variant
      (assignment (identifier) @type.enum.variant (operator) (_))
      (assignment (juxtaposition_expression (identifier) @type.enum.variant))
    ]
  ))

((prefixed_string_literal
  (identifier) @function.macro) @string.regexp
  (#eq? @function.macro "r"))

; attribute - Class attributes, HTML tag attributes

; TODO: clean up
; TODO: document & test
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
(typed_expression (_) "::" (identifier) @type)
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
        (field_expression (_) (identifier) @type)
        (unary_expression (identifier) @type)
      ])
    (field_expression (_) "." (identifier) @type)
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
  [
    (abstract_definition)
    (assignment)
    (compound_statement)
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
; must be before `(identifier) @variable`
(field_expression (_) (identifier) @variable.other.member)
; must be before `(identifier) @variable`
((identifier) @variable.builtin
  (#any-of? @variable.builtin "begin" "end")
  (#has-ancestor? @variable.builtin index_expression))
; TODO: clean up
; TODO: document & test
(argument_list
  [
    (identifier) @variable.parameter
    (named_argument
      [
        (identifier) @variable.parameter
        (typed_expression (identifier) @variable.parameter)
      ])
    (typed_expression (identifier) @variable.parameter)
    (tuple_expression
      [
        (identifier) @variable.parameter
        (typed_expression (identifier) @variable.parameter)
      ])
  ])
(identifier) @variable

; label

; punctuation
;     delimiter - Commas, colons
;     bracket - Parentheses, angle brackets, etc.
;     special - String interpolation brackets.
(selected_import [":" ","] @punctuation.delimiter)
(open_tuple "," @punctuation.delimiter)
(let_statement "," @punctuation.delimiter)
(for_clause "," @punctuation.delimiter)
(for_statement "," @punctuation.delimiter)
(export_statement "," @punctuation.delimiter)
(public_statement "," @punctuation.delimiter)
(vector_expression "," @punctuation.delimiter)
(curly_expression "," @punctuation.delimiter)
(argument_list ["," ";"] @punctuation.delimiter)
(tuple_expression ["," ";"] @punctuation.delimiter)
(parenthesized_expression ";" @punctuation.delimiter)
(string_interpolation ["(" ")"] @punctuation.special)

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
