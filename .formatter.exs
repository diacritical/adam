[
  force_do_end_blocks: true,
  import_deps: [:plug],
  inputs: [
    ".{boundary,credo,dialyzer,formatter}.exs",
    "{config,lib,support,test}/**/*.{ex,exs}",
    "mix.exs"
  ],
  line_length: 80
]
