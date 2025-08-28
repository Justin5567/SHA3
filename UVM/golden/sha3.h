#ifndef __SHA3_H
#define __SHA3_H

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <string.h>

#define SHA3_224_DIGEST_SIZE (224 / 8)
#define SHA3_224_BLOCK_SIZE (200 - 2 * SHA3_224_DIGEST_SIZE)
#define SHA3_256_DIGEST_SIZE (256 / 8)
#define SHA3_256_BLOCK_SIZE (200 - 2 * SHA3_256_DIGEST_SIZE)
#define SHA3_384_DIGEST_SIZE (384 / 8)
#define SHA3_384_BLOCK_SIZE (200 - 2 * SHA3_384_DIGEST_SIZE)
#define SHA3_512_DIGEST_SIZE (512 / 8)
#define SHA3_512_BLOCK_SIZE (200 - 2 * SHA3_512_DIGEST_SIZE)
#define SHA3_DEFAULT_BLOCK_SIZE    SHA3_256_BLOCK_SIZE
#define SHA3_DEFAULT_DIGEST_SIZE   SHA3_256_DIGEST_SIZE

#define KECCAK_ROUNDS 24
#define ROTL64(x, y) (((x) << (y)) | ((x) >> (64 - (y))))

typedef struct {
  uint64_t st[25];
  unsigned int md_len;
  unsigned int rsiz;
  unsigned int rsizw;
  unsigned int partial;
  uint8_t buf[SHA3_DEFAULT_BLOCK_SIZE];  
} sha3_state;

// Function prototypes
int sha3ONE(const unsigned char *, unsigned int, unsigned char *);
void sha3_init(sha3_state *sctx);
void sha3_update(sha3_state *sctx, const uint8_t *data, unsigned int len);
void sha3_final(sha3_state *sctx, uint8_t *out);

void hash_init_sha3(void * ctx);
void hash_update_sha3(void * ctx, const uint8_t * input, size_t length);
void hash_final_sha3(void * ctx, unsigned char * digest);

void printState(uint64_t st[25]);

#endif