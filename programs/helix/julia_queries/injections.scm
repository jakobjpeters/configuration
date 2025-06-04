; (
;   (source_file
;     (string_literal) @injection.content
;     .
;     [
;       (abstract_definition)
;       (assignment)
;       (const_statement)
;       (function_definition)
;       (identifier)
;       (macro_definition)
;       (module_definition)
;       (primitive_definition)
;       (struct_definition)
;     ])
;   (#set! injection.language "markdown"))

; (
;   (source_file (string_literal))
;   (#set! injection.language "markdown"))
; (
;   (module_definition (string_literal))
;   (#set! injection.language "markdown"))

(
  [
    (line_comment)
    (block_comment)
  ] @injection.content
  (#set! injection.language "comment"))

; (
;   (prefixed_string_literal
;     prefix: (identifier) @function.macro) @injection.content
;   (#eq? @function.macro "r")
;   (#set! injection.language "regex"))

; (
;   (prefixed_string_literal
;     prefix: (identifier) @function.macro) @injection.content
;   (#eq? @function.macro "md")
;   (#set! injection.language "markdown"))

; (
;   (prefixed_string_literal
;     prefix: (identifier) @function.macro) @injection.content
;   (#eq? @function.macro "html")
;   (#set! injection.language "html"))

; (
;   (prefixed_string_literal
;     prefix: (identifier) @function.macro) @injection.content
;   (#eq? @function.macro "typst")
;   (#set! injection.language "typst"))
