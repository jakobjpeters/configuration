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
  (source_file (string_literal (content) @injection.content))
  (#set! injection.language "markdown"))
(
  (module_definition (string_literal (content) @injection.content))
  (#set! injection.language "markdown"))

(
  (macrocall_expression
    (macro_identifier "@" (identifier) @doc
      (#eq? @doc "doc"))
    (macro_argument_list
      (string_literal (content) @injection.content)
      (_)))
  (#set! injection.language "markdown"))

(
  [(line_comment) (block_comment)] @injection.content
  (#set! injection.language "comment"))

(
  (prefixed_string_literal
    (identifier) @r
    (content) @injection.content)
  (#eq? @r "r")
  (#set! injection.language "regex"))

(
  (prefixed_string_literal
    (identifier) @md
    (content) @injection.content)
  (#eq? @md "md")
  (#set! injection.language "markdown"))

(
  (prefixed_string_literal
    (identifier) @html
    (content) @injection.content)
  (#eq? @html "html")
  (#set! injection.language "html"))

(
  (prefixed_string_literal
    (identifier) @typst
    (content) @injection.content)
  (#eq? @typst "typst")
  (#set! injection.language "typst"))
