morloc_and <- function(x, y) {
  bitwAnd(x, y)
}

morloc_or <- function(x, y) {
  bitwOr(x, y)
}

morloc_xor <- function(x, y) {
  bitwXor(x, y)
}

morloc_shiftl <- function(x, n) {
  bitwShiftL(x, n)
}

morloc_shiftr <- function(x, n) {
  bitwShiftR(x, n)
}

morloc_bnot <- function(x) {
  bitwNot(x)
}

morloc_testBit <- function(x, n) {
  bitwAnd(bitwShiftR(x, n), 1L) == 1L
}

morloc_setBit <- function(x, n) {
  bitwOr(x, bitwShiftL(1L, n))
}

morloc_clearBit <- function(x, n) {
  bitwAnd(x, bitwNot(bitwShiftL(1L, n)))
}

morloc_flipBit <- function(x, n) {
  bitwXor(x, bitwShiftL(1L, n))
}

morloc_popcount <- function(x) {
  count <- 0L
  v <- x
  while (v != 0L) {
    count <- count + bitwAnd(v, 1L)
    v <- bitwShiftR(bitwAnd(v, .Machine$integer.max), 1L)
  }
  count
}
