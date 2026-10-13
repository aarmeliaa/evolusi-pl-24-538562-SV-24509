<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\Task;

// Endpoint untuk mendapatkan semua data tugas
Route::get('/tasks', function () {
    return response()->json(Task::all());
});