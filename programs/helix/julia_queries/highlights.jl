
# combination

## ((prefixed_string_literal (identifier) @function.macro) @string.regexp (#eq? @function.macro "r"))
r""

## (macrocall_expression (macro_identifier "@" (identifier) @function.macro (#eq? @function.macro "enum")) (macro_argument_list [ (identifier) @type.enum (typed_expression (identifier) @type.enum "::" (_)) ] [ (identifier) @type.enum.variant (assignment (identifier) @type.enum.variant (operator) (_)) (assignment (juxtaposition_expression (identifier) @type.enum.variant)) ] ))
@enum X::Int a b = 2

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

## (where_expression (identifier) @type)
T where T

## (where_expression (binary_expression (identifier) @type))
T where T <: Any

## (where_expression (curly_expression (identifier) @type))
T where {T}

## (where_expression (curly_expression (binary_expression (identifier) @type)))
T where {T <: T}

## (parametrized_type_expression (identifier) @type)
Union{}

## (parametrized_type_expression (curly_expression (identifier) @type.parameter))
Vector{T}

## (parametrized_type_expression (curly_expression (field_expression (_) "." (identifier) @type)))
Vector{Base.T}

## (parametrized_type_expression (curly_expression (unary_expression (identifier) @type)))
Vector{<:Any}

## (parametrized_type_expression (field_expression (_) (identifier) @type))
Vector{Base.Vector{T}}

## ((identifier) @type.builtin (#any-of @type.builtin ...))
AbstractArray

# constructor

# constant

## ((identifier) @constant.builtin (#any-of @constant.builtin "nothing" "undef"))
nothing

# comment

## (line_comment) @comment.line
#

## (block_comment) @comment.block
#==#

## ((string_literal) @comment.block.documentation [...])
""
x

# string

## (string_literal) @string
"" * ""

## (escape_sequence) @string.escape
"\n" * "\t"

## (command_literal) @string.special
``

## (quote_expression ":" @string.special.symbol (identifier) @string.special.symbol)
:x

## (quote_expression ":" @string.special.symbol (operator) @string.special.symbol)
:+

# variable

## (field_expression (identifier) @variable.member .)
x.y

## ((identifier) @variable.builtin (#any-of? @variable.builtin "begin" "end") (#has-ancestor? @variable.builtin index_expression))
x[begin:end]

## (identifier) @variable
x

# label

# punctuation

## (selected_import [":" ","] @punctuation.delimiter)
using X: a, b,

## (open_tuple "," @punctuation.delimiter)
a, b

## (let_statement "," @punctuation.delimiter)
let a, b
    1
end

## (for_statement "," @punctuation.delimiter)
for a in 1, b in 2
    3
end

## (export_statement "," @punctuation.delimiter)
export a, b

## (public_statement "," @punctuation.delimiter)
public a, b

## (for_statement "," @punctuation.delimiter)
[1 for x in 1, y in 2]

## (vector_expression "," @punctuation.delimiter)
[1, 2,]

## (curly_expression "," @punctuation.delimiter)
T where {T, U,}

## (argument_list "," @punctuation.delimiter)
f(1, 2,)

## (argument_list ";" @punctuation.delimiter)
f(;)

## (tuple_expression "," @punctuation.delimiter)
(1, 2,)

## (tuple_expression ";" @punctuation.delimiter)
(;)

## (parenthesized_expression ";" @punctuation.delimiter)
(1; 2;)

## (string_interpolation ["(", ")"] @punctuation.special)
"$(x)"
