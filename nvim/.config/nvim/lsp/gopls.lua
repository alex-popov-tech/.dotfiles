return {
  settings = {
    gopls = {
      -- formatting
      gofumpt = true, -- use gofumpt instead of gofmt

      -- code lenses
      codelenses = {
        generate = true,            -- run go generate
        regenerate_cgo = true,      -- re-run cgo declarations
        run_govulncheck = true,     -- run vulnerability check
        test = false,               -- run tests/benchmarks from codelens
        tidy = true,                -- run go mod tidy
        upgrade_dependency = true,  -- check for dependency upgrades
        vendor = true,              -- update vendor directory
      },

      -- inlay hints
      hints = {
        assignVariableTypes = true,    -- var types in assignments
        compositeLiteralFields = true, -- field names in composite literals
        compositeLiteralTypes = true,  -- types in composite literals
        constantValues = true,         -- values of constants
        functionTypeParameters = true, -- type params on generic functions
        parameterNames = true,         -- parameter names in function calls
        rangeVariableTypes = true,     -- var types in range statements
        ignoredError = true,           -- implicitly discarded errors
      },

      -- analyzers
      analyses = {
        -- gopls analyzers
        any = true,               -- replace interface{} with any
        appends = true,           -- check for missing values after append
        asmdecl = true,           -- assembly/Go declaration mismatches
        assign = true,            -- useless assignments
        atomic = true,            -- common sync/atomic mistakes
        atomicalign = true,       -- non-64-bit-aligned atomic args
        bools = true,             -- common boolean operator mistakes
        buildtag = true,          -- check //go:build directives
        cgocall = true,           -- cgo pointer passing violations
        composites = true,        -- unkeyed composite literals
        copylocks = true,         -- locks passed by value
        deepequalerrors = true,   -- reflect.DeepEqual on error values
        defers = true,            -- common defer mistakes
        deprecated = true,        -- use of deprecated identifiers
        directive = true,         -- check Go toolchain directives
        embed = true,             -- check //go:embed usage
        errorsas = true,          -- invalid errors.As arguments
        fillreturns = true,       -- fix incorrect return values
        framepointer = true,      -- assembly clobbering frame pointer
        httpresponse = true,      -- HTTP response mistakes
        ifaceassert = true,       -- impossible interface assertions
        loopclosure = true,       -- loop var refs in nested functions
        lostcancel = true,        -- context.WithCancel cancel not called
        nilfunc = true,           -- useless func/nil comparisons
        nilness = true,           -- redundant/impossible nil comparisons
        printf = true,            -- Printf format string consistency
        shadow = true,            -- variable shadowing
        shift = true,             -- shifts exceeding integer width
        sigchanyzer = true,       -- unbuffered os.Signal channel
        simplifycompositelit = true, -- composite literal simplifications
        simplifyrange = true,     -- range statement simplifications
        simplifyslice = true,     -- slice simplifications
        slog = true,              -- invalid structured logging calls
        sortslice = true,         -- sort.Slice argument type check
        stdmethods = true,        -- well-known interface signatures
        stdversion = true,        -- too-new stdlib symbols
        stringintconv = true,     -- string(int) conversions
        structtag = true,         -- struct field tag conformance
        testinggoroutine = true,  -- T.Fatal from test goroutines
        tests = true,             -- mistaken test/example usage
        timeformat = true,        -- time.Parse with wrong date
        unmarshal = true,         -- invalid unmarshal arguments
        unreachable = true,       -- unreachable code
        unsafeptr = true,         -- invalid uintptr to unsafe.Pointer
        unusedfunc = true,        -- unused functions/methods
        unusedparams = true,      -- unused function parameters
        unusedresult = true,      -- unused call results
        unusedvariable = true,    -- unused variables
        unusedwrite = true,       -- unused writes
      },

      staticcheck = true,      -- enable staticcheck.io analyzers
      semanticTokens = true,   -- enable semantic token highlighting
      usePlaceholders = true,  -- placeholders for function params in completion
    },
  },
}
