# TAHAP 1: BUILDER (Fase Pembangunan)
FROM php:8.4.1-cli-alpine AS builder

# Install utilitas sistem yang dibutuhkan Composer
RUN apk add --no-cache zip unzip git sqlite

COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer
WORKDIR /app

# Manfaatkan cache untuk instalasi dependensi
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Salin sisa kode aplikasi
COPY . .

# TAHAP 2: RUNNER (Fase Produksi Ringan)
FROM php:8.4.1-cli-alpine

RUN apk add --no-cache sqlite
WORKDIR /app

# Hanya salin hasil aplikasi yang sudah matang dari tahap builder
COPY --from=builder /app /app

# Inisialisasi basis data
RUN cp .env.example .env \
    && rm -f bootstrap/cache/*.php \
    && touch database/database.sqlite \
    && php artisan key:generate \
    && php artisan migrate --force

# Amankan direktori agar bisa diakses oleh user non-root
RUN chown -R www-data:www-data /app

# SYARAT KEAMANAN MUTLAK: Jangan pernah jalankan kontainer sebagai root
USER www-data

# HEALTHCHECK: Pastikan kontainer melaporkan status sehat ke Docker Daemon
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://127.0.0.1:8000/api/tasks || exit 1

EXPOSE 8000

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]