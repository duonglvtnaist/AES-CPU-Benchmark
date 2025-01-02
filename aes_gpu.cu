#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include "aes.h"

#define AES_BLOCK_SIZE 16

__device__ void AES_init_ctx_iv_device(struct AES_ctx* ctx, const uint8_t* key, const uint8_t* iv) {
    // Initialize the AES context with the key
    memcpy(ctx->RoundKey, key, AES_BLOCK_SIZE);
    memcpy(ctx->Iv, iv, AES_BLOCK_SIZE);
}

__device__ void AES_ECB_encrypt_device(const struct AES_ctx* ctx, uint8_t* buf) {
    // Implement the AES ECB encryption logic here
    // This is a simplified example and may not be secure
    for (int i = 0; i < AES_BLOCK_SIZE; ++i) {
        buf[i] ^= ctx->RoundKey[i];
    }
}

__device__ void AES_CBC_encrypt_buffer_device(struct AES_ctx* ctx, uint8_t* buf, size_t length) {
    uint8_t* Iv = ctx->Iv;
    for (size_t i = 0; i < length; i += AES_BLOCK_SIZE) {
        for (size_t j = 0; j < AES_BLOCK_SIZE; ++j) {
            buf[i + j] ^= Iv[j];
        }
        AES_ECB_encrypt_device(ctx, buf + i);
        memcpy(Iv, buf + i, AES_BLOCK_SIZE);
    }
}

__global__ void aes_encrypt_cbc_kernel(uint8_t* d_in, uint8_t* d_out, uint8_t* d_key, uint8_t* d_iv, int length) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < length / AES_BLOCK_SIZE) {
        struct AES_ctx ctx;
        AES_init_ctx_iv_device(&ctx, d_key, d_iv);
        AES_CBC_encrypt_buffer_device(&ctx, d_in + idx * AES_BLOCK_SIZE, AES_BLOCK_SIZE);
        memcpy(d_out + idx * AES_BLOCK_SIZE, d_in + idx * AES_BLOCK_SIZE, AES_BLOCK_SIZE);
    }
}

void aes_encrypt_cbc(uint8_t* in, uint8_t* out, uint8_t* key, uint8_t* iv, int length) {
    uint8_t *d_in, *d_out, *d_key, *d_iv;

    cudaMalloc((void**)&d_in, length);
    cudaMalloc((void**)&d_out, length);
    cudaMalloc((void**)&d_key, AES_BLOCK_SIZE);
    cudaMalloc((void**)&d_iv, AES_BLOCK_SIZE);

    cudaMemcpy(d_in, in, length, cudaMemcpyHostToDevice);
    cudaMemcpy(d_key, key, AES_BLOCK_SIZE, cudaMemcpyHostToDevice);
    cudaMemcpy(d_iv, iv, AES_BLOCK_SIZE, cudaMemcpyHostToDevice);

    int blockSize = 256;
    int numBlocks = (length / AES_BLOCK_SIZE + blockSize - 1) / blockSize;
    aes_encrypt_cbc_kernel<<<numBlocks, blockSize>>>(d_in, d_out, d_key, d_iv, length);

    cudaMemcpy(out, d_out, length, cudaMemcpyDeviceToHost);

    cudaFree(d_in);
    cudaFree(d_out);
    cudaFree(d_key);
    cudaFree(d_iv);
}

int main() {
#if defined(AES256)
    uint8_t key[] = { 0x60, 0x3d, 0xeb, 0x10, 0x15, 0xca, 0x71, 0xbe, 0x2b, 0x73, 0xae, 0xf0, 0x85, 0x7d, 0x77, 0x81,
                      0x1f, 0x35, 0x2c, 0x07, 0x3b, 0x61, 0x08, 0xd7, 0x2d, 0x98, 0x10, 0xa3, 0x09, 0x14, 0xdf, 0xf4 };
#elif defined(AES192)
    uint8_t key[] = { 0x8e, 0x73, 0xb0, 0xf7, 0xda, 0x0e, 0x64, 0x52, 0xc8, 0x10, 0xf3, 0x2b, 0x80, 0x90, 0x79, 0xe5, 0x62, 0xf8, 0xea, 0xd2, 0x52, 0x2c, 0x6b, 0x7b };
#elif defined(AES128)
    uint8_t key[] = { 0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c };
#endif
    uint8_t iv[]  = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
    uint8_t in[]  = { 0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a,
                      0xae, 0x2d, 0x8a, 0x57, 0x1e, 0x03, 0xac, 0x9c, 0x9e, 0xb7, 0x6f, 0xac, 0x45, 0xaf, 0x8e, 0x51,
                      0x30, 0xc8, 0x1c, 0x46, 0xa3, 0x5c, 0xe4, 0x11, 0xe5, 0xfb, 0xc1, 0x19, 0x1a, 0x0a, 0x52, 0xef,
                      0xf6, 0x9f, 0x24, 0x45, 0xdf, 0x4f, 0x9b, 0x17, 0xad, 0x2b, 0x41, 0x7b, 0xe6, 0x6c, 0x37, 0x10 };
    uint8_t out[sizeof(in)];

    aes_encrypt_cbc(in, out, key, iv, sizeof(in));

    printf("CBC encrypt: ");
    if (0 == memcmp((char*) out, (char*) in, sizeof(in))) {
        printf("SUCCESS!\n");
    } else {
        printf("FAILURE!\n");
    }

    return 0;
}