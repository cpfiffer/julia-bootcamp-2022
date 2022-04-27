using Test
unstable(x) = x <= 0 ? 0 : x

@inferred unstable(1.0)
# @code_warntype unstable(1.0)