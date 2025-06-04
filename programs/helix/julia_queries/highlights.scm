
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
; clipboard(join(map(name -> "\"$name\"", unique(Iterators.flatmap(_module -> filter(name -> getproperty(_module, name) isa Type && name != :(=>), names(_module)), [Base, Core]))), ' '))
((identifier) @type.builtin (#any-of? @type.builtin
  "AbstractChannel" "AbstractDict" "AbstractDisplay" "AbstractIrrational" "AbstractLock" "AbstractMatch" "AbstractMatrix" "AbstractPattern" "AbstractPipe" "AbstractRange" "AbstractSet" "AbstractSlices" "AbstractUnitRange" "AbstractVecOrMat" "AbstractVector" "Array" "AsyncCondition" "BigFloat" "BigInt" "BitArray" "BitMatrix" "BitSet" "BitVector" "BufferStream" "CanonicalIndexError" "CapturedException" "CartesianIndex" "CartesianIndices" "Cchar" "Cdouble" "Cfloat" "Channel" "Cint" "Cintmax_t" "Clong" "Clonglong" "Cmd" "CodeUnits" "Colon" "ColumnSlices" "Complex" "ComplexF16" "ComplexF32" "ComplexF64" "ComposedFunction" "CompositeException" "Condition" "Cptrdiff_t" "Cshort" "Csize_t" "Cssize_t" "Cstring" "Cuchar" "Cuint" "Cuintmax_t" "Culong" "Culonglong" "Cushort" "Cwchar_t" "Cwstring" "DenseMatrix" "DenseVecOrMat" "DenseVector" "Dict" "DimensionMismatch" "Dims" "EOFError" "Enum" "Event" "ExponentialBackOff" "Fix1" "Fix2" "Generator" "HTML" "IOBuffer" "IOContext" "IOServer" "IOStream" "IdDict" "IdSet" "ImmutableDict" "IndexCartesian" "IndexLinear" "IndexStyle" "InvalidStateException" "Irrational" "IteratorEltype" "IteratorSize" "KeyError" "LazyString" "LinRange" "LinearIndices" "Lockable" "LogRange" "MIME" "Matrix" "Missing" "MissingException" "NTuple" "OS_HANDLE" "OneTo" "OrdinalRange" "Pair" "PartialQuickSort" "PermutedDimsArray" "Pipe" "PipeEndpoint" "ProcessFailedException" "Rational" "RawFD" "ReentrantLock" "Regex" "RegexMatch" "Returns" "RoundingMode" "RowSlices" "Semaphore" "Set" "Slices" "Some" "StepRange" "StepRangeLen" "StridedArray" "StridedMatrix" "StridedVecOrMat" "StridedVector" "StringIndexError" "SubArray" "SubString" "SubstitutionString" "SystemError" "TTY" "TaskFailedException" "Text" "TextDisplay" "Timer" "UUID" "UnitRange" "Val" "VecOrMat" "Vector" "VersionNumber" "WeakKeyDict" "AbstractArray" "AbstractChar" "AbstractFloat" "AbstractString" "Any" "ArgumentError" "AssertionError" "AtomicMemory" "AtomicMemoryRef" "Bool" "BoundsError" "Char" "ConcurrencyViolationError" "Cvoid" "DataType" "DenseArray" "DivideError" "DomainError" "ErrorException" "Exception" "Expr" "Float16" "Float32" "Float64" "Function" "GenericMemory" "GenericMemoryRef" "GlobalRef" "IO" "InexactError" "InitError" "Int" "Int128" "Int16" "Int32" "Int64" "Int8" "Integer" "InterruptException" "LineNumberNode" "LoadError" "Memory" "MemoryRef" "Method" "MethodError" "Module" "NamedTuple" "Nothing" "Number" "OutOfMemoryError" "OverflowError" "Ptr" "QuoteNode" "ReadOnlyMemoryError" "Real" "Ref" "SegmentationFault" "Signed" "StackOverflowError" "String" "Symbol" "Task" "Tuple" "Type" "TypeError" "TypeVar" "UInt" "UInt128" "UInt16" "UInt32" "UInt64" "UInt8" "UndefInitializer" "UndefKeywordError" "UndefRefError" "UndefVarError" "Union" "UnionAll" "Unsigned" "VecElement" "WeakRef"))

; constructor

; constant (TODO: constant.other.placeholder for %v)
;     builtin Special constants provided by the language (true, false, nil etc)
;         boolean
;     character
;         escape
;     numeric (numbers)
;         integer
;         float
(boolean_literal) @constant.builtin.boolean
(integer_literal) @constant.numeric.integer
(float_literal) @constant.numeric.float
(character_literal) @constant.character
; TODO: make numbers a `@constanct.numeric`?
; clipboard(join(map(name -> "\"$name\"", unique(Iterators.flatmap(_module -> filter(name -> isconst(_module, name) && !(getproperty(_module, name) isa Union{Function, Type, Module}), names(_module)), [Base, Core]))), ' '))
((identifier) @constant.builtin (#any-of? @constant.builtin
  "ARGS" "C_NULL" "DEPOT_PATH" "DL_LOAD_PATH" "ENDIAN_BOM" "ENV" "Inf" "Inf16" "Inf32" "Inf64" "InsertionSort" "LOAD_PATH" "MergeSort" "NaN" "NaN16" "NaN32" "NaN64" "QuickSort" "RoundDown" "RoundFromZero" "RoundNearest" "RoundNearestTiesAway" "RoundNearestTiesUp" "RoundToZero" "RoundUp" "VERSION" "devnull" "im" "missing" "pi" "text_colors" "π" "ℯ" "Vararg" "nothing" "undef"))

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
  [(identifier) (operator)] @string.special.symbol)

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
["," ";"] @punctuation.delimiter
(selected_import ":" @punctuation.delimiter)
; must be before `["(" ")" "[" "]" "{" "}"] @punctuation.bracket`
(string_interpolation ["(" ")"] @punctuation.special)
["(" ")" "[" "]" "{" "}"] @punctuation.bracket

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
(if_statement ["if" "end"] @keyword.control.conditional)
(elseif_clause "elseif" @keyword.control.conditional)
(else_clause "else" @keyword.control.conditional)
(ternary_expression ["?" ":"] @keyword.control.conditional)
(if_clause "if" @keyword.conditional)
(for_statement ["for" "end"] @keyword.repeat)
(for_binding "outer" @keyword.repeat)
(for_clause "for" @keyword.repeat)
(while_statement ["while" "end"] @keyword.repeat)
[(break_statement) (continue_statement)] @keyword.repeat
(module_definition ["module" "baremodule" "end"] @keyword.import)
(export_statement "export" @keyword.import)
(public_statement "public" @keyword.import)
(import_statement "import" @keyword.import)
(using_statement "using" @keyword.import)
(import_alias "as" @keyword.import)
(return_statement "return" @keyword.return)
(try_statement ["try" "end"] @keyword.exception)
(catch_clause "catch" @keyword.exception)
(finally_clause "finally" @keyword.exception)
(for_binding (operator) @keyword.operator)
(where_expression "where" @keyword.operator)
(function_definition ["function" "end"] @keyword.function)
(do_clause ["do" "end"] @keyword.function)
(arrow_function_expression "->" @keyword.function)
(abstract_definition ["abstract" "type"] @keyword.storage.type)
(primitive_definition ["primitive" "type"] @keyword.storage.type)
(struct_definition "mutable" @keyword.storage.type)
(local_statement "local" @keyword.storage.modifier)
(const_statement "const" @keyword.storage.modifier)
(let_statement ["let" "end"] @keyword)
(compound_statement ["begin" "end"] @keyword)
(quote_statement ["quote" "end"] @keyword)
(quote_expression ":" @keyword)
(macro_definition ["macro" "end"] @keyword)

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
