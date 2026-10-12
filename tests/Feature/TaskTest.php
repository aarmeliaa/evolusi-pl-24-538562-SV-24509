<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use App\Models\Task;

class TaskTest extends TestCase
{
    use RefreshDatabase; // Membersihkan database setiap kali test berjalan

    public function test_can_create_a_task()
    {
        // Buat Task baru
        Task::create([
            'title' => 'Belajar CI/CD GitHub Actions',
        ]);

        // Memastikan data masuk ke database
        $this->assertDatabaseHas('tasks', [
            'title' => 'Belajar CI/CD GitHub Actions',
        ]);
    }
}