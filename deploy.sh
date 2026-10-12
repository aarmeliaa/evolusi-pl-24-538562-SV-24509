#!/bin/bash
set -e

echo "1. Memasuki mode maintenance (php artisan down)..."
echo "2. Menarik kode terbaru dari repository (git pull)..."
echo "3. Menginstal dependensi (composer install --no-dev)..."
echo "4. Menjalankan migrasi database (php artisan migrate)..."
echo "5. Membersihkan cache (php artisan optimize:clear)..."
echo "6. Membuat ulang cache cache (php artisan optimize)..."
echo "7. Mematikan mode maintenance (php artisan up)..."
