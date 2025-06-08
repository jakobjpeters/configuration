
; `list_builtins(predicate) = clipboard(join(map(name -> escape_string("\"$name\"", '\\'), unique(Iterators.flatmap(_module -> filter(name -> predicate(_module, name), names(_module)), [Base, Core]))), ' '))`

; TODO: context-dependent symbols
; `const` as a `@keyword.storage.modifier` vs `@keyword.storage.type`
; `:` as an `@operator` vs `@keyword.control.conditional` vs `@string.special.symbol` vs `@keyword`
; `$` as an `@operator` vs `@keyword`
; struct & enum identifier vs call as a `@type` vs ?
; `<:` as an `@operator` vs `@keyword.operator`
; `=>` as ?

; TODO: pascal case regex --> `@type`?
; TODO: screaming snake case regex --> `@constant`?
; TODO: handle `>:`

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
    (identifier) @type.parameter
    (binary_expression
      (identifier) @type.parameter
      (operator)
      (identifier) @type)
    (binary_expression
      (identifier) @type.parameter
      (operator)
      (_))
  ])
(parametrized_type_expression (identifier) @type)
(curly_expression
  [
    (identifier) @type.parameter
    (field_expression (_) "." (identifier) @type.parameter)
    (unary_expression (identifier) @type)
    (binary_expression
      (identifier) @type.parameter
      (operator)
      (identifier) @type)
    (binary_expression
      (identifier) @type.parameter
      (operator)
      (_))
  ])
(macrocall_expression
  (macro_identifier "@" (identifier) @enum
    (#eq? @enum "enum"))
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
; `list_builtins((_module, name) -> name != :(=>) && getproperty(_module, name) isa Type)`
((identifier) @type.builtin (#any-of? @type.builtin
  "AbstractChannel" "AbstractDict" "AbstractDisplay" "AbstractIrrational" "AbstractLock" "AbstractMatch" "AbstractMatrix" "AbstractPattern" "AbstractPipe" "AbstractRange" "AbstractSet" "AbstractSlices" "AbstractUnitRange" "AbstractVecOrMat" "AbstractVector" "Array" "AsyncCondition" "BigFloat" "BigInt" "BitArray" "BitMatrix" "BitSet" "BitVector" "BufferStream" "CanonicalIndexError" "CapturedException" "CartesianIndex" "CartesianIndices" "Cchar" "Cdouble" "Cfloat" "Channel" "Cint" "Cintmax_t" "Clong" "Clonglong" "Cmd" "CodeUnits" "Colon" "ColumnSlices" "Complex" "ComplexF16" "ComplexF32" "ComplexF64" "ComposedFunction" "CompositeException" "Condition" "Cptrdiff_t" "Cshort" "Csize_t" "Cssize_t" "Cstring" "Cuchar" "Cuint" "Cuintmax_t" "Culong" "Culonglong" "Cushort" "Cwchar_t" "Cwstring" "DenseMatrix" "DenseVecOrMat" "DenseVector" "Dict" "DimensionMismatch" "Dims" "EOFError" "Enum" "Event" "ExponentialBackOff" "Fix1" "Fix2" "Generator" "HTML" "IOBuffer" "IOContext" "IOServer" "IOStream" "IdDict" "IdSet" "ImmutableDict" "IndexCartesian" "IndexLinear" "IndexStyle" "InvalidStateException" "Irrational" "IteratorEltype" "IteratorSize" "KeyError" "LazyString" "LinRange" "LinearIndices" "Lockable" "LogRange" "MIME" "Matrix" "Missing" "MissingException" "NTuple" "OS_HANDLE" "OneTo" "OrdinalRange" "Pair" "PartialQuickSort" "PermutedDimsArray" "Pipe" "PipeEndpoint" "ProcessFailedException" "Rational" "RawFD" "ReentrantLock" "Regex" "RegexMatch" "Returns" "RoundingMode" "RowSlices" "Semaphore" "Set" "Slices" "Some" "StepRange" "StepRangeLen" "StridedArray" "StridedMatrix" "StridedVecOrMat" "StridedVector" "StringIndexError" "SubArray" "SubString" "SubstitutionString" "SystemError" "TTY" "TaskFailedException" "Text" "TextDisplay" "Timer" "UUID" "UnitRange" "Val" "VecOrMat" "Vector" "VersionNumber" "WeakKeyDict" "AbstractArray" "AbstractChar" "AbstractFloat" "AbstractString" "Any" "ArgumentError" "AssertionError" "AtomicMemory" "AtomicMemoryRef" "Bool" "BoundsError" "Char" "ConcurrencyViolationError" "Cvoid" "DataType" "DenseArray" "DivideError" "DomainError" "ErrorException" "Exception" "Expr" "Float16" "Float32" "Float64" "Function" "GenericMemory" "GenericMemoryRef" "GlobalRef" "IO" "InexactError" "InitError" "Int" "Int128" "Int16" "Int32" "Int64" "Int8" "Integer" "InterruptException" "LineNumberNode" "LoadError" "Memory" "MemoryRef" "Method" "MethodError" "Module" "NamedTuple" "Nothing" "Number" "OutOfMemoryError" "OverflowError" "Ptr" "QuoteNode" "ReadOnlyMemoryError" "Real" "Ref" "SegmentationFault" "Signed" "StackOverflowError" "String" "Symbol" "Task" "Tuple" "Type" "TypeError" "TypeVar" "UInt" "UInt128" "UInt16" "UInt32" "UInt64" "UInt8" "UndefInitializer" "UndefKeywordError" "UndefRefError" "UndefVarError" "Union" "UnionAll" "Unsigned" "VecElement" "WeakRef"))

; constructor

; comment - Code comments
;     line - Single line comments (//)
;     block - Block comments (e.g. (/* */)
;         documentation - Documentation comments (e.g. /// in Rust)
(line_comment) @comment.line
(block_comment) @comment.block
; must match before `(string_literal) @string`
(source_file (string_literal) @comment.block.documentation)
(module_definition (string_literal) @comment.block.documentation)
(macrocall_expression
  (macro_identifier "@" (identifier) @doc
    (#eq? @doc "doc"))
  (macro_argument_list
    [
      (string_literal)
      (prefixed_string_literal
        (identifier) @md (#eq? @md "md"))
    ] @comment.block.documentation
    (_)))

; string (TODO: string.quoted.{single, double}, string.raw/.unquoted)?
;     regexp - Regular expressions
;     special
;         path
;         url
;         symbol - Erlang/Elixir atoms, Ruby symbols, Clojure keywords
(string_literal) @string
((prefixed_string_literal
  (identifier) @r) @string.regexp
  (#eq? @r "r"))
(command_literal) @string.special
(quote_expression ":" [(identifier) (operator)]) @string.special.symbol
; must be before `(integer_literal) @constant.numeric.integer`
(
  (quote_expression
    ":"
    (integer_literal) @integer_literal
    (#match? @integer_literal "[0-9]{20}")) @string.special.symbol)

; constant (TODO: constant.other.placeholder for %v)
;     builtin Special constants provided by the language (true, false, nil etc)
;         boolean
;     character
;         escape
;     numeric (numbers)
;         integer
;         float
; `list_builtins((_module, name) -> isconst(_module, name) && getproperty(_module, name) isa Union{AbstractIrrational, Complex, Rational})`
(
  (identifier) @constant.numeric
  (#any-of? @constant.numeric "im" "pi" "π" "ℯ"))
(integer_literal) @constant.numeric.integer
; `list_builtins((_module, name) -> isconst(_module, name) && getproperty(_module, name) isa Integer)`
(
  (identifier) @constant.numeric.integer
  (#any-of? @constant.numeric.integer "ENDIAN_BOM"))
(float_literal) @constant.numeric.float
; `list_builtins((_module, name) -> isconst(_module, name) && getproperty(_module, name) isa AbstractFloat)`
((identifier) @constant.numeric.float (#any-of? @constant.numeric.float
  "Inf" "Inf16" "Inf32" "Inf64" "NaN" "NaN16" "NaN32" "NaN64"))
(escape_sequence) @constant.character.escape
(
  (character_literal) @constant.character.escape
  (#match?
    @constant.character.escape
    "\\\\([^uUx0-7]|[uU][0-9a-fA-F]{1,6}|[0-7]{1,3}|x[0-9a-fA-F]{2})"))
(character_literal) @constant.character
(boolean_literal) @constant.builtin.boolean
; `list_builtins((_module, name) -> isconst(_module, name) && !(getproperty(_module, name) isa Union{Function, Number, Type}))`
((identifier) @constant.builtin (#any-of? @constant.builtin
  "ARGS" "Base" "Broadcast" "C_NULL" "Checked" "DEPOT_PATH" "DL_LOAD_PATH" "Docs" "ENV" "Filesystem" "GC" "InsertionSort" "Iterators" "LOAD_PATH" "Libc" "MathConstants" "MergeSort" "Meta" "Order" "QuickSort" "RoundDown" "RoundFromZero" "RoundNearest" "RoundNearestTiesAway" "RoundNearestTiesUp" "RoundToZero" "RoundUp" "ScopedValues" "Sort" "StackTraces" "Sys" "Threads" "VERSION" "devnull" "missing" "text_colors" "Core" "Main" "Vararg" "nothing" "undef"))

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
(if_clause "if" @keyword.control.conditional)
(for_statement ["for" "end"] @keyword.control.repeat)
(for_binding "outer" @keyword.control.repeat)
(for_clause "for" @keyword.control.repeat)
(while_statement ["while" "end"] @keyword.control.repeat)
[(break_statement) (continue_statement)] @keyword.control.repeat
(module_definition ["module" "baremodule" "end"] @keyword.control.import)
(export_statement "export" @keyword.control.import)
(public_statement "public" @keyword.control.import)
(import_statement "import" @keyword.control.import)
(using_statement "using" @keyword.control.import)
(import_alias "as" @keyword.control.import)
(return_statement "return" @keyword.control.return)
(try_statement ["try" "end"] @keyword.control.exception)
(catch_clause "catch" @keyword.control.exception)
(finally_clause "finally" @keyword.control.exception)
(for_binding (operator) @keyword.operator)
(where_expression "where" @keyword.operator)
(signature (typed_expression "::" @keyword.operator))
(arrow_function_expression (typed_expression "::" @keyword.operator))
(do_clause (argument_list (typed_expression "::" @keyword.operator)))
(macrocall_expression
  (macro_identifier "@" (identifier) @enum
    (#eq? @enum "enum"))
  (macro_argument_list
    (typed_expression (identifier) "::" @keyword.operator (_))
    [
      (identifier)
      (assignment (identifier) (operator) (_))
      (assignment (juxtaposition_expression (identifier)))
    ]
  ))
(unary_typed_expression "::" @keyword.operator)
; must be before `(identifier) @variable`
(
  (identifier) @keyword.operator
  (#any-of? @keyword.operator "begin" "end")
  (#has-ancestor? @keyword.operator index_expression))
(function_definition ["function" "end"] @keyword.function)
(do_clause ["do" "end"] @keyword.function)
(arrow_function_expression "->" @keyword.function)
(abstract_definition ["abstract" "type" "end"] @keyword.storage.type)
(primitive_definition ["primitive" "type" "end"] @keyword.storage.type)
(struct_definition ["mutable" "struct" "end"] @keyword.storage.type)
(local_statement "local" @keyword.storage.modifier)
(const_statement "const" @keyword.storage.modifier)
(let_statement ["let" "end"] @keyword)
(compound_statement ["begin" "end"] @keyword)
(quote_statement ["quote" "end"] @keyword)
(quote_expression ":" @keyword)
(macro_definition ["macro" "end"] @keyword)

; operator - ||, +=, >
(operator) @operator
(adjoint_expression "'" @operator)
(range_expression ":" @operator)
(field_expression "." @operator)
(splat_expression "..." @operator)
(typed_expression "::" @operator)
(interpolation_expression "$" @operator)
(string_interpolation "$" @operator)

; function
;     builtin
;     method
;         private - Private methods that use a unique syntax (currently just ECMAScript-based languages)
;     macro
;     special (preprocessor in C)
(call_expression (identifier) @function)
(call_expression (field_expression (_) "." (identifier) @function))
(broadcast_call_expression (field_expression (_) "." (identifier) @function))
(macro_definition
  (signature
    [
      (identifier) @function.macro
      (call_expression (identifier) @function.macro)
    ]))
(macro_identifier (identifier) @function.macro) @function.macro
; `list_builtins((_module, name) -> isletter(string(name)[1]) && getproperty(_module, name) isa Function)`
((identifier) @function.builtin (#any-of? @function.builtin
  "PipeBuffer" "abs" "abs2" "abspath" "accumulate" "accumulate!" "acos" "acosd" "acosh" "acot" "acotd" "acoth" "acquire" "acsc" "acscd" "acsch" "active_project" "addenv" "adjoint" "all" "all!" "allequal" "allunique" "angle" "any" "any!" "append!" "argmax" "argmin" "ascii" "asec" "asecd" "asech" "asin" "asind" "asinh" "asyncmap" "asyncmap!" "atan" "atand" "atanh" "atexit" "atreplinit" "axes" "backtrace" "basename" "big" "bind" "binomial" "bitreverse" "bitrotate" "bitstring" "broadcast" "broadcast!" "bswap" "bytes2hex" "bytesavailable" "cat" "catch_backtrace" "cbrt" "cconvert" "cd" "ceil" "cglobal" "checkbounds" "checked_length" "checkindex" "chmod" "chomp" "chop" "chopprefix" "chopsuffix" "chown" "circcopy!" "circshift" "circshift!" "cis" "cispi" "clamp" "clamp!" "cld" "close" "closewrite" "cmp" "coalesce" "code_lowered" "code_typed" "codepoint" "codeunit" "codeunits" "collect" "complex" "conj" "conj!" "contains" "contractuser" "convert" "copy" "copy!" "copyline" "copysign" "copyto!" "copyuntil" "cos" "cosc" "cosd" "cosh" "cospi" "cot" "cotd" "coth" "count" "count!" "count_ones" "count_zeros" "countlines" "cp" "csc" "cscd" "csch" "ctime" "cumprod" "cumprod!" "cumsum" "cumsum!" "current_exceptions" "current_task" "deepcopy" "deg2rad" "delete!" "deleteat!" "denominator" "depwarn" "detach" "diff" "digits" "digits!" "dirname" "disable_sigint" "diskstat" "display" "displayable" "displaysize" "div" "divrem" "download" "dropdims" "dump" "eachcol" "eachindex" "eachline" "eachmatch" "eachrow" "eachrsplit" "eachslice" "eachsplit" "elsize" "eltype" "empty" "empty!" "endswith" "enumerate" "eof" "eps" "error" "errormonitor" "esc" "escape_string" "evalfile" "evalpoly" "exit" "exit_on_sigint" "exp" "exp10" "exp2" "expanduser" "expm1" "exponent" "extrema" "extrema!" "factorial" "falses" "fd" "fdio" "fetch" "fieldcount" "fieldname" "fieldnames" "fieldoffset" "fieldtypes" "filemode" "filesize" "fill" "fill!" "filter" "filter!" "finalize" "finalizer" "findall" "findfirst" "findlast" "findmax" "findmax!" "findmin" "findmin!" "findnext" "findprev" "first" "firstindex" "fld" "fld1" "fldmod" "fldmod1" "flipsign" "float" "floatmax" "floatmin" "floor" "flush" "fma" "foldl" "foldr" "foreach" "fourthroot" "frexp" "front" "fullname" "functionloc" "gcd" "gcdx" "gensym" "get" "get!" "get_zero_subnormals" "gethostname" "getindex" "getkey" "getpid" "getproperty" "gperm" "hardlink" "hasfield" "hash" "haskey" "hasmethod" "hasproperty" "hcat" "hex2bytes" "hex2bytes!" "homedir" "htol" "hton" "hvcat" "hvncat" "hypot" "identify_package" "identity" "ifelse" "ignorestatus" "imag" "in" "in!" "include_dependency" "include_string" "indexin" "insert!" "insorted" "instances" "intersect" "intersect!" "inv" "invmod" "invokelatest" "invperm" "invpermute!" "isabspath" "isabstracttype" "isambiguous" "isapprox" "isascii" "isassigned" "isbinaryoperator" "isbits" "isbitstype" "isblockdev" "ischardev" "iscntrl" "isconcretetype" "isconst" "isdigit" "isdir" "isdirpath" "isdisjoint" "isdispatchtuple" "isdone" "isempty" "isequal" "iseven" "isexecutable" "isexported" "isexpr" "isfifo" "isfile" "isfinite" "isidentifier" "isimmutable" "isinf" "isinteger" "isinteractive" "isless" "isletter" "islink" "islocked" "islowercase" "ismarked" "ismissing" "ismount" "ismutable" "ismutabletype" "isnan" "isnothing" "isnumeric" "isodd" "isone" "isopen" "isoperator" "ispath" "isperm" "ispow2" "isprimitivetype" "isprint" "ispublic" "ispunct" "isqrt" "isreadable" "isreadonly" "isready" "isreal" "issetequal" "issetgid" "issetuid" "issingletontype" "issocket" "issorted" "isspace" "issticky" "isstructtype" "issubnormal" "issubset" "istaskdone" "istaskfailed" "istaskstarted" "istextmime" "isunaryoperator" "isunordered" "isuppercase" "isvalid" "iswritable" "isxdigit" "iszero" "iterate" "jit_total_bytes" "join" "joinpath" "keepat!" "keys" "keytype" "kill" "kron" "kron!" "last" "lastindex" "lcm" "ldexp" "leading_ones" "leading_zeros" "length" "link_pipe!" "load_path" "locate_package" "lock" "log" "log10" "log1p" "log2" "logrange" "lowercase" "lowercasefirst" "lpad" "lstat" "lstrip" "ltoh" "macroexpand" "map" "map!" "mapfoldl" "mapfoldr" "mapreduce" "mapslices" "mark" "match" "max" "maximum" "maximum!" "maxintfloat" "memoryref" "merge" "merge!" "mergewith" "mergewith!" "methods" "min" "minimum" "minimum!" "minmax" "mkdir" "mkpath" "mktemp" "mktempdir" "mod" "mod1" "mod2pi" "modf" "modifyproperty!" "moduleroot" "mtime" "muladd" "mv" "nameof" "names" "nand" "ncodeunits" "ndigits" "ndims" "nextfloat" "nextind" "nextpow" "nextprod" "nonmissingtype" "nor" "normpath" "notify" "notnothing" "ntoh" "ntuple" "numerator" "objectid" "occursin" "oftype" "one" "ones" "oneunit" "only" "open" "operator_associativity" "operator_precedence" "operm" "pairs" "parent" "parentindices" "parentmodule" "parse" "partialsort" "partialsort!" "partialsortperm" "partialsortperm!" "pathof" "peek" "permute!" "permutedims" "permutedims!" "pipeline" "pkgdir" "pkgversion" "pointer" "pointer_from_objref" "pop!" "popat!" "popdisplay" "popfirst!" "position" "powermod" "precision" "precompile" "prepend!" "prevfloat" "prevind" "prevpow" "print" "println" "printstyled" "process_exited" "process_running" "prod" "prod!" "promote" "promote_rule" "promote_shape" "promote_type" "propertynames" "push!" "pushdisplay" "pushfirst!" "put!" "pwd" "rad2deg" "rand" "randn" "range" "rationalize" "read" "read!" "readavailable" "readbytes!" "readchomp" "readdir" "readeach" "readline" "readlines" "readlink" "readuntil" "real" "realpath" "redirect_stderr" "redirect_stdin" "redirect_stdio" "redirect_stdout" "redisplay" "reduce" "reenable_sigint" "reim" "reinterpret" "release" "relpath" "rem" "rem2pi" "remove_linenums!" "repeat" "replace" "replace!" "replaceproperty!" "repr" "reset" "reseteof" "reshape" "resize!" "rest" "rethrow" "retry" "reverse" "reverse!" "reverseind" "rm" "rot180" "rotl90" "rotr90" "round" "rounding" "rpad" "rsplit" "rstrip" "run" "runtests" "samefile" "schedule" "searchsorted" "searchsortedfirst" "searchsortedlast" "sec" "secd" "sech" "seek" "seekend" "seekstart" "selectdim" "set_zero_subnormals" "setcpuaffinity" "setdiff" "setdiff!" "setenv" "setindex!" "setprecision" "setproperty!" "setpropertyonce!" "setrounding" "show" "showable" "showerror" "sign" "signbit" "signed" "significand" "similar" "sin" "sinc" "sincos" "sincosd" "sincospi" "sind" "sinh" "sinpi" "size" "sizehint!" "sizeof" "skip" "skipchars" "skipmissing" "sleep" "something" "sort" "sort!" "sortperm" "sortperm!" "sortslices" "splat" "splice!" "split" "split_rest" "splitdir" "splitdrive" "splitext" "splitpath" "sprint" "sqrt" "stack" "stacktrace" "startswith" "stat" "step" "stride" "strides" "string" "strip" "success" "sum" "sum!" "summary" "summarysize" "supertype" "swapproperty!" "symdiff" "symdiff!" "symlink" "systemerror" "tail" "take!" "tan" "tand" "tanh" "tanpi" "task_local_storage" "tempdir" "tempname" "textwidth" "thisind" "time" "time_ns" "timedwait" "titlecase" "to_index" "to_indices" "touch" "trailing_ones" "trailing_zeros" "transcode" "transpose" "trues" "trunc" "truncate" "trylock" "tryparse" "typeintersect" "typejoin" "typemax" "typemin" "unescape_string" "union" "union!" "unique" "unique!" "unlock" "unmark" "unsafe_convert" "unsafe_copyto!" "unsafe_load" "unsafe_modify!" "unsafe_pointer_to_objref" "unsafe_read" "unsafe_replace!" "unsafe_store!" "unsafe_string" "unsafe_swap!" "unsafe_trunc" "unsafe_wrap" "unsafe_write" "unsigned" "uperm" "uppercase" "uppercasefirst" "valtype" "values" "vcat" "vec" "vect" "view" "wait" "walkdir" "which" "widemul" "widen" "windowserror" "withenv" "write" "xor" "yield" "yieldto" "zero" "zeros" "zip" "applicable" "arrayref" "arrayset" "arraysize" "const_arrayref" "eval" "fieldtype" "getfield" "getglobal" "invoke" "isa" "isdefined" "modifyfield!" "modifyglobal!" "nfields" "replacefield!" "replaceglobal!" "setfield!" "setfieldonce!" "setglobal!" "setglobalonce!" "swapfield!" "swapglobal!" "throw" "tuple" "typeassert" "typeof"))

; tag - Tags (e.g. <body> in HTML)
;     builtin

; namespace
(module_definition (identifier) @namespace)

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

; variable - Variables
;     builtin - Reserved language variables (self, this, super, etc.)
;     parameter - Function parameters
;     other
;         member - Fields of composite data types (e.g. structs, unions)
;             private - Private fields that use a unique syntax (currently just ECMAScript-based languages)
; must be before `(identifier) @variable`
(field_expression (_) "." (identifier) @variable.other.member)
; `list_builtins(!isconst)
; must be before `(identifier) @variable`
(
  (identifier) @variable.builtin
  (#any-of? @variable.builtin
    "PROGRAM_FILE" "stderr" "stdin" "stdout"))
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
