
Main.x

# TODO: command literals

# attribute

# type

## (type_head (identifier) @type)
struct A end

## (type_head (binary_expression (identifier) @type))
struct B <: Any end

## (unary_typed_expression (identifier) @type)
f(::Vector) = nothing

## (typed_expression (_) "::" (identifier) @type)
1::Int

## (where_expression (identifier) @type.parameter)
T where T

## (where_expression (binary_expression (identifier) @type.parameter "<:" (identifier) @type))
T where T <: Any

## (where_expression (curly_expression (identifier) @type.parameter))
T where {T}

## (where_expression (curly_expression (binary_expression (identifier) @type.parameter "<:" (identifier) @type)))
T where {T <: Any}

## (parametrized_type_expression (identifier) @type)
Union{}

## (parametrized_type_expression (curly_expression (identifier) @type.parameter))
Vector{T}

## (parametrized_type_expression (curly_expression (field_expression (_) "." (identifier) @type.parameter)))
Vector{Base.T}

## (parametrized_type_expression (curly_expression (unary_expression (identifier) @type)))
Vector{<:Any}

## (parametrized_type_expression (curly_expression (binary_expression (identifier) @type.parameter "<:" (_))))
struct X{T<:Any} end

## (parametrized_type_expression (field_expression (_) "." (identifier) @type))
Vector{Base.Vector{T}}

## (macrocall_expression (macro_identifier "@" (identifier) @enum (#eq? @enum "enum")) (macro_argument_list [ (identifier) @type.enum (typed_expression (identifier) @type.enum "::" (_)) ] [ (identifier) @type.enum.variant (assignment (identifier) @type.enum.variant "=" (_)) (assignment (juxtaposition_expression (identifier) @type.enum.variant)) ] ))
@enum X::Int a b = 2

## ((identifier) @type.builtin (#any-of @type.builtin ...))
AbstractArray

# constructor

# constant

## (boolean_literal) @constant.boolean
true

## (integer_literal) @constant.numeric.integer
1

## (float_literal) @constant.numeric.float
1.0

## (character_literal) @constant.character
' '
'\n'
begin "a\nb" end

## ((identifier) @constant.builtin (#any-of @constant.builtin ...))
nothing

# comment

## (line_comment) @comment.line
#

## (block_comment) @comment.block
#==#

## (source_file (string_literal) @comment.block.documentation)
""

## (module_definition (string_literal) @comment.block.documentation)
module X "" end

## (macrocall_expression (macro_identifier "@" (identifier) @doc (#eq? @doc "doc")) (macro_argument_list [(string_literal) (prefixed_string_literal (identifier) @md (#eq? @md "md"))] @comment.block.documentation (_)))
@doc md"" x

# string

## (string_literal) @string
begin "" end

## ((prefixed_string_literal (identifier) @r) @string.regexp (#eq? @r "r"))
r""

## (escape_sequence) @string.escape
"\n" * "\t"

## (command_literal) @string.special
``

## (quote_expression ":" @string.special.symbol (identifier) @string.special.symbol)
:x

## (quote_expression ":" @string.special.symbol (operator) @string.special.symbol)
:+

# variable

## (field_expression (_) (identifier) @variable.member .)
x.y

# ((identifier) @variable.builtin (#any-of? @variable.builtin "PROGRAM_FILE" "stderr" "stdin" "stdout"))
stdout

## ((identifier) @variable.builtin (#any-of? @variable.builtin "begin" "end") (#has-ancestor? @variable.builtin index_expression))
x[begin:end]

## (identifier) @variable
x

# label

# punctuation

## ["," ";"] @punctuation.delimiter
(;)

## (selected_import ":" @punctuation.delimiter)
using Base: Int

## ["(" ")" "[" "]" "{" "}"] @punctuation.bracket
[]

## (string_interpolation ["(" ")"] @punctuation.special)
"$()"

# keyword

## (if_statement ["if" "end"] @keyword.control.conditional)
if true end

## (elseif_clause "elseif" @keyword.control.conditional)
if true elseif false end

## (else_clause "else" @keyword.control.conditional)
if true else end

## (ternary_expression ["?" ":"] @keyword.control.conditional)
true ? 1 : 2

## (if_clause "if" @keyword.control.conditional)
[i for i in 1 if true]

## (for_statement ["for" "end"] @keyword.control.repeat)
for i in 1 end

## (for_binding "outer" @keyword.control.repeat)
for outer i in 1 end

## (for_clause "for" @keyword.control.repeat)
[i for i in 1]

## (while_statement ["while" "end"] @keyword.control.repeat)
while true end

## [(break_statement) (continue_statement)] @keyword.control.repeat
while true
    continue
    break
end

## (module_definition ["module" "baremodule" "end"] @keyword.control.import)
module X end

## (export_statement "export" @keyword.control.import)
export x

## (public_statement "public" @keyword.control.import)
public x

## (import_statement "import" @keyword.control.import)
import Base: Int

## (using_statement "using" @keyword.control.import)
using Base: Int

## (import_alias "as" @keyword.control.import)
using Base: Int as x

## (return_statement "return" @keyword.control.return)
f() = return x

## (try_statement ["try" "end"] @keyword.control.exception)
try catch end

## (catch_clause "catch" @keyword.control.exception)
try catch end

## (finally_clause "finally" @keyword.control.exception)
try catch finally end

## (for_binding (operator) @keyword.operator)
for i in 1 end

## (where_expression "where" @keyword.operator)
T where T

## (function_definition ["function" "end"] @keyword.function)
function f end

## (do_clause ["do" "end"] @keyword.function)
f() do nothing end

## (arrow_function_expression "->" @keyword.function)
x -> x

## (abstract_definition ["abstract" "type" "end"] @keyword.storage.type)
abstract type X end

## (primitive_definition ["primitive" "type" "end"] @keyword.storage.type)
primitive type X 8 end

## (struct_definition ["mutable" "struct" "end"] @keyword.storage.type)
mutable struct X end

## (local_statement "local" @keyword.storage.modifier)
local x

## (const_statement "const" @keyword.storage.modifier)
const x = 1

## (let_statement ["let" "end"] @keyword)
let x = 1; end

## (compound_statement ["begin" "end"] @keyword)
begin end

## (quote_statement ["quote" "end"] @keyword)
quote end

## (quote_expression ":" @keyword)
:()

## (macro_definition ["macro" "end"] @keyword)
macro m end

# operator

## (operator) @operator
=>

## (adjoint_expression "'" @operator)
x'

## (range_expression ":" @operator)
1:2

## (field_expression ":" @operator)
x.a

## (splat_expression "..." @operator)
(xs...)

## (typed_expression "::" @operator)
1::Int

## (unary_typed_expression "::" @operator)
f(::Int) = 1

## (interpolation_expression "$" @operator)
:($x)

## (string_interpolation "$" @operator)
"$x"
