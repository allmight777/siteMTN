<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\SiteController;
use App\Http\Controllers\Admin\StatsController;
use App\Models\Site;

// Route pour afficher la page principale
Route::get('/', function () {
    return view('welcome');
});

// Route pour afficher le dashboard admin
Route::get('/dashboard', function () {
    $totalSites = Site::count(); // récupère le nombre réel de sites
    return view('dashboard', compact('totalSites'));
})->middleware(['auth', 'verified'])->name('dashboard');

//Route pour les fonctionnalite de l'admin
Route::middleware(['auth'])->group(function () {

    //Route pour gérer les sites
    Route::resource('sites', SiteController::class);

    //Routes pour les statistiques des sites
    Route::get('/stats', [StatsController::class, 'index'])->name('stats.index');
});


Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
