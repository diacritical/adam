%{
  configs: [
    %{
      checks: %{
        enabled: [
          {Credo.Check.Consistency.ExceptionNames, []},
          {Credo.Check.Consistency.LineEndings, []},
          {Credo.Check.Consistency.MultiAliasImportRequireUse, []},
          {Credo.Check.Consistency.ParameterPatternMatching, []},
          {Credo.Check.Consistency.SpaceAroundOperators, []},
          {Credo.Check.Consistency.SpaceInParentheses, []},
          {Credo.Check.Consistency.TabsOrSpaces, []},
          {Credo.Check.Consistency.UnusedVariableNames, []},
          {Credo.Check.Readability.AliasOrder, []},
          {Credo.Check.Readability.BlockPipe, []},
          {Credo.Check.Readability.FunctionNames, []},
          {Credo.Check.Readability.ImplTrue, []},
          {Credo.Check.Readability.LargeNumbers, only_greater_than: 999},
          {
            Credo.Check.Readability.MaxLineLength,
            [
              max_length: 80,
              ignore_definitions: false,
              ignore_strings: false,
              ignore_urls: false
            ]
          },
          {Credo.Check.Readability.ModuleAttributeNames, []},
          {Credo.Check.Readability.ModuleDoc, ignore_names: []},
          {Credo.Check.Readability.ModuleNames, []},
          {Credo.Check.Readability.NestedFunctionCalls, []},
          {Credo.Check.Readability.ParenthesesInCondition, []},
          {Credo.Check.Readability.ParenthesesOnZeroArityDefs, parens: true},
          {Credo.Check.Readability.PipeIntoAnonymousFunctions, []},
          {Credo.Check.Readability.PredicateFunctionNames, []},
          {Credo.Check.Readability.PreferImplicitTry, []},
          {Credo.Check.Readability.RedundantBlankLines, []},
          {Credo.Check.Readability.Semicolons, []},
          {Credo.Check.Readability.SeparateAliasRequire, []},
          {Credo.Check.Readability.SingleFunctionToBlockPipe, []},
          {Credo.Check.Readability.SinglePipe, allow_0_arity_functions: true},
          {Credo.Check.Readability.SpaceAfterCommas, []},
          {Credo.Check.Readability.Specs, include_defp: true},
          {Credo.Check.Readability.StrictModuleLayout, []},
          {Credo.Check.Readability.StringSigils, []},
          {Credo.Check.Readability.TrailingBlankLine, []},
          {Credo.Check.Readability.TrailingWhiteSpace, []},
          {Credo.Check.Readability.UnnecessaryAliasExpansion, []},
          {Credo.Check.Readability.VariableNames, []},
          {Credo.Check.Readability.WithCustomTaggedTuple, []},
          {Credo.Check.Readability.WithSingleClause, []},
          {Credo.Check.Refactor.ABCSize, []},
          {Credo.Check.Refactor.AppendSingleItem, []},
          {Credo.Check.Refactor.Apply, []},
          {Credo.Check.Refactor.CondStatements, []},
          {Credo.Check.Refactor.CyclomaticComplexity, []},
          {Credo.Check.Refactor.DoubleBooleanNegation, []},
          {Credo.Check.Refactor.FilterFilter, []},
          {Credo.Check.Refactor.FilterReject, []},
          {Credo.Check.Refactor.FunctionArity, []},
          {Credo.Check.Refactor.IoPuts, []},
          {Credo.Check.Refactor.LongQuoteBlocks, ignore_comments: true},
          {Credo.Check.Refactor.MapJoin, []},
          {Credo.Check.Refactor.MapMap, []},
          {Credo.Check.Refactor.MatchInCondition, []},
          {Credo.Check.Refactor.NegatedConditionsInUnless, []},
          {Credo.Check.Refactor.NegatedConditionsWithElse, []},
          {Credo.Check.Refactor.NegatedIsNil, []},
          {Credo.Check.Refactor.Nesting, []},
          {Credo.Check.Refactor.PipeChainStart, []},
          {Credo.Check.Refactor.RedundantWithClauseResult, []},
          {Credo.Check.Refactor.RejectFilter, []},
          {Credo.Check.Refactor.RejectReject, []},
          {Credo.Check.Refactor.UnlessWithElse, []},
          {Credo.Check.Refactor.VariableRebinding, allow_bang: true},
          {Credo.Check.Refactor.WithClauses, []},
          {Credo.Check.Warning.ApplicationConfigInModuleAttribute, []},
          {Credo.Check.Warning.BoolOperationOnSameValues, []},
          {Credo.Check.Warning.ExpensiveEmptyEnumCheck, []},
          {Credo.Check.Warning.ForbiddenModule, modules: []},
          {Credo.Check.Warning.IExPry, []},
          {Credo.Check.Warning.IoInspect, []},
          {Credo.Check.Warning.LeakyEnvironment, []},
          {Credo.Check.Warning.MapGetUnsafePass, []},
          {Credo.Check.Warning.MixEnv, []},
          {Credo.Check.Warning.OperationOnSameValues, []},
          {Credo.Check.Warning.OperationWithConstantResult, []},
          {Credo.Check.Warning.RaiseInsideRescue, []},
          {Credo.Check.Warning.SpecWithStruct, []},
          {Credo.Check.Warning.UnsafeExec, []},
          {Credo.Check.Warning.UnsafeToAtom, []},
          {Credo.Check.Warning.UnusedEnumOperation, []},
          {Credo.Check.Warning.UnusedFileOperation, []},
          {Credo.Check.Warning.UnusedKeywordOperation, []},
          {Credo.Check.Warning.UnusedListOperation, []},
          {Credo.Check.Warning.UnusedPathOperation, []},
          {Credo.Check.Warning.UnusedRegexOperation, []},
          {Credo.Check.Warning.UnusedStringOperation, []},
          {Credo.Check.Warning.UnusedTupleOperation, []},
          {Credo.Check.Warning.WrongTestFileExtension, []}
        ],
        disabled: [
          {Credo.Check.Design.AliasUsage, []},
          {Credo.Check.Design.DuplicatedCode, []},
          {Credo.Check.Design.SkipTestWithoutComment, []},
          {Credo.Check.Design.TagFIXME, []},
          {Credo.Check.Design.TagTODO, []},
          {Credo.Check.Readability.AliasAs, []},
          {Credo.Check.Readability.MultiAlias, []},
          {Credo.Check.Readability.PreferUnquotedAtoms, []},
          {Credo.Check.Refactor.CaseTrivialMatches, []},
          {Credo.Check.Refactor.MapInto, []},
          {Credo.Check.Refactor.ModuleDependencies, []},
          {Credo.Check.Refactor.PerceivedComplexity, []},
          {Credo.Check.Warning.LazyLogging, []}
        ]
      },
      color: true,
      files: %{
        included: [
          ".boundary.exs",
          ".credo.exs",
          ".dialyzer.exs",
          ".formatter.exs",
          "{lib,support,test}/**/*.{ex,exs}",
          "mix.exs"
        ]
      },
      name: "app",
      parse_timeout: 5_000,
      plugins: [],
      requires: [],
      strict: true
    }
  ]
}
