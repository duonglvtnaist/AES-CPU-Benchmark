# Tiny AES Timing Test

This project is designed to measure the execution time of AES encryption and decryption on various CPUs and GPUs. It is based on the [Tiny AES in C](https://github.com/kokke/tiny-AES-c) library, which provides a small and portable implementation of the AES encryption algorithms.

## Overview

The primary goal of this project is to check the timing for AES operations when running on different hardware platforms. The supported AES modes include:
- ECB (Electronic Codebook)
- CTR (Counter)
- CBC (Cipher Block Chaining)

## Usage

The API is simple and includes the following functions:

```c
void AES_init_ctx(struct AES_ctx* ctx, const uint8_t* key);
void AES_init_ctx_iv(struct AES_ctx* ctx, const uint8_t* key, const uint8_t* iv);
void AES_ctx_set_iv(struct AES_ctx* ctx, const uint8_t* iv);

void AES_ECB_encrypt(const struct AES_ctx* ctx, uint8_t* buf);
void AES_ECB_decrypt(const struct AES_ctx* ctx, uint8_t* buf);

void AES_CBC_encrypt_buffer(struct AES_ctx* ctx, uint8_t* buf, size_t length);
void AES_CBC_decrypt_buffer(struct AES_ctx* ctx, uint8_t* buf, size_t length);

void AES_CTR_xcrypt_buffer(struct AES_ctx* ctx, uint8_t* buf, size_t length);

```

## Important Notes

- No padding is provided, so for CBC and ECB all buffers should be multiples of 16 bytes.
- ECB mode is considered unsafe for most uses and is not implemented in streaming mode.
- This project focuses on timing measurements rather than high performance or security.

## Building and Running

To build and run the project, use the provided Makefile or CMake configuration. The timing results will be printed to the console.

## License

This project inherits from the Tiny AES in C library and follows the same licensing terms. See the original [Tiny AES in C repository] (https://github.com/kokke/tiny-AES-c) for more details.