
# tree-sitter error
# let a, b end

# (;;)

# mutable struct X
#     const x::Int
# end

# """
# - x
# """ x

# tree-sitter error
# "- x" x

# what does this do in `indents.scm`?
# [
#   "end"
# ] @outdent

function f(a, b)
    a + b
end

@doc """
- x
""" x

"""
- x
"""
x

r"[a-z]*"

typst"""
- x
= x
# x
"""

typst"-x"

md"""
# X
- x
"""
