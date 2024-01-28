// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/// @title PrimeFieldArithmetic
/// @notice Library for performing arithmetic operations in a prime field
/// @author Diego (0xfuturistic@pm.me)
library PrimeFieldArithmetic {
    /// @notice The prime number from the secp256k1 curve is used.
    uint256 constant PRIME = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F;

    /// @notice Adds two numbers in the prime field
    /// @param a The first number to add
    /// @param b The second number to add
    /// @return The sum of a and b in the prime field
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return addmod(a, b, PRIME);
    }

    /// @notice Subtracts one number from another in the prime field
    /// @param a The number to subtract from
    /// @param b The number to subtract
    /// @return The result of subtracting b from a in the prime field
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return addmod(a, PRIME - (b % PRIME), PRIME);
    }

    /// @notice Multiplies two numbers in the prime field
    /// @param a The first number to multiply
    /// @param b The second number to multiply
    /// @return The product of a and b in the prime field
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return mulmod(a, b, PRIME);
    }

    /// @notice Calculates the modular multiplicative inverse of a number a modulo p using the formula  a^(p-2) mod p.
    ///         This is based on Fermat's Little Theorem, which states that  a^(p-1) ≡ 1 mod p for any non-zero a in a field of size p.
    /// @param a The number to calculate the inverse of
    /// @return The modular multiplicative inverse of a in the prime field
    function inv(uint256 a) internal pure returns (uint256) {
        require(a != 0, "division by zero");
        return exp(a, PRIME - 2);
    }

    /// @notice Divides one number by another in the prime field
    /// @param a The number to divide
    /// @param b The number to divide by
    /// @return The result of dividing a by b in the prime field
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return mul(a, inv(b));
    }

    /// @notice Calculates the modular exponentiation of a number a raised to the power of b in the prime field using the square-and-multiply algorithm.
    /// @param a The base number
    /// @param b The exponent
    /// @return The result of raising a to the power of b in the prime field
    function exp(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 result = 1;
        a %= PRIME;
        for (uint256 i = 1; i <= b; i *= 2) {
            if (b & i != 0) {
                result = mulmod(result, a, PRIME);
            }
            a = mulmod(a, a, PRIME);
        }
        return result;
    }
}
