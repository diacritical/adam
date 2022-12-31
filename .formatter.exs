[
  force_do_end_blocks: true,
  inputs: [
    ".{boundary,credo,dialyzer,formatter}.exs",
    "{lib,test}/**/*.{ex,exs}",
    "mix.exs"
  ],
  line_length: 80
]
