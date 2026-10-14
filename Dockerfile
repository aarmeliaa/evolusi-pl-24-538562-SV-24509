# Menggunakan image PHP 8.4 agar sesuai dengan kebutuhan Laravel terbaru
FROM php:8.4-cli

# Menginstal dependensi sistem yang dibutuhkan Composer & Laravel
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    sqlite3 \
    && docker-php-ext-install zip pdo pdo_mysql

# Menyalin Composer dari image resminya
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Menentukan direktori kerja di dalam container
WORKDIR /app

# STRATEGI CACHE: Salin file dependensi terlebih dahulu
COPY composer.json composer.lock ./

# Instal dependensi (tahap ini akan disimpan dalam cache Docker)
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Salin seluruh sisa kode aplikasi
COPY . .

# Siapkan environment dan database SQLite bawaan untuk testing
RUN cp .env.example .env \
    && rm -f bootstrap/cache/*.php \
    && touch database/database.sqlite \
    && php artisan key:generate \
    && php artisan migrate --force

# Buka port 8000
EXPOSE 8000

# Jalankan server bawaan Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]