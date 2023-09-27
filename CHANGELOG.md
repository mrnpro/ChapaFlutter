## 0.0.1

* initial release.

## 0.0.2

* Updated txRefRandomGenerator implementation from using math.random to uuid for improved randomness and uniqueness of transaction references.
* Updated dependencies to ensure compatibility with the latest Flutter version.
* Fixed a bug that caused crashes when certain conditions were met.

## 0.0.3

* Continued functionality without user input: If the user does not provide a transaction reference (txReference), the package now seamlessly generates a unique reference code with the prefix "test-". This ensures that the program can continue to function smoothly, even in cases where user input is absent.