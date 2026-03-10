# bits-r

R implementations for the morloc `Bits` typeclass.

## R integer limitations

R uses 32-bit signed integers (`integer` type), with a range of
[-2^31, 2^31 - 1] (i.e., -2147483648 to 2147483647). This has several
consequences for bitwise operations:

- **No unsigned integers.** R has no unsigned integer type. All integer values
  are signed, so bitwise NOT of 0 yields -1 (two's complement), not
  4294967295.

- **Overflow to NA.** Values exceeding the 32-bit signed range silently become
  `NA`. For example, `bitwAnd(x, 0xFFFFFFFFL)` fails because `0xFFFFFFFF`
  (4294967295) exceeds `integer.max` and R coerces the hex literal to `NA`.

- **popcount workaround.** The `popcount` implementation must avoid masking
  with `0xFFFFFFFF`. Instead, it uses `bitwAnd(v, .Machine$integer.max)` before
  right-shifting to clear the sign bit and prevent `NA` propagation during the
  bit-counting loop.

- **Shift and NOT edge cases.** `bitwShiftL` and `bitwNot` operate on 32-bit
  signed integers. Shifting `1L` left by 31 positions yields `-2147483648`
  (the minimum integer), not `2147483648`. This is correct two's complement
  behavior but may be surprising.

These limitations mean the R `Bits` instance is only reliable for values
that fit in 32-bit signed integers. For wider integer operations, use the
Python or C++ backends.
