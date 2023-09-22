<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('purchase', function (Blueprint $table) {
            $table->id();
            $table->string('reference')->required();
            $table->dateTime('purchaseStartDate');
            $table->dateTime('purchaseEndDate');
            $table->string('image')->required();
             $table->boolean('etat')->default(false);
            $table->decimal('total', 10, 2);
            $table->string('description')->required();

            $table->unsignedBigInteger('client_id');
            $table->foreign('client_id')->references('id')->on('client');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('purchase');
    }
};
