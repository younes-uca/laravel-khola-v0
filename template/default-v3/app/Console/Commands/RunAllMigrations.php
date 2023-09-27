<?php
// app/Console/Commands/RunAllMigrations.php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Artisan;

class RunAllMigrations extends Command
{
    protected $signature = 'migrate:all';
    protected $description = 'Run migrations from all subdirectories';

    public function handle()
    {
        $migrationPath = database_path('migrations');

        // Get a list of subdirectories
        $subdirectories = scandir($migrationPath);

        foreach ($subdirectories as $subdirectory) {
            if ($subdirectory !== '.' && $subdirectory !== '..' && is_dir($migrationPath . DIRECTORY_SEPARATOR . $subdirectory)) {
                $subdirectoryPath = $migrationPath . DIRECTORY_SEPARATOR . $subdirectory;
                $this->info("command::::: migrate --path database/migrations/$subdirectory");
                Artisan::call('migrate', ['--path' => "database/migrations/$subdirectory"]);
            }
        }
    }
}

