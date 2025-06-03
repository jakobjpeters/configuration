
# attribute

# type

## (type_head (identifier) @type)
struct A end

## (type_head (binary_expression (identifier) @type))
struct B <: Any end

## (unary_typed_expression (identifier) @type)
f(::Vector) = nothing

## (typed_expression (identifier) @type)
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

## (parametrized_type_expression (curly_expression (unary_expression (identifier) @type)))
Vector{<:Any}

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

## ((string_literal) @comment.block.documentation . ())
""
abstract type X end

# ((string_literal) @comment.block.documentation . (assignment))
""
x = 1

## ((string_literal) @comment.block.documentation . (const_statement))
""
const x = 1

## ((string_literal) @comment.block.documentation . (function_definition))
""
function f end

## ((string_literal) @comment.block.documentation . (identifier))
""
x

## ((string_literal) @comment.block.documentation . (macro_definition))
""
macro m end

## ((string_literal) @comment.block.documentation . (module_definition))
""
module M end

## ((string_literal) @comment.block.documentation . (primitive_definition))
""
primitive type X 8 end

## ((string_literal) @comment.block.documentation . (struct_definition))
""
struct X end

# string

## (string_literal) @string
""

## (escape_sequence) @string.escape
"\n"

## (command_literal) @string.special
``

## (quote_expression ":" @string.special.symbol (identifier) @string.special.symbol)
:x

## (quote_expression ":" @string.special.symbol (operator) @string.special.symbol)
:+

# variable

## (identifier) @variable
# x

## (field_expression (identifier) @variable.member .)
# x.y
