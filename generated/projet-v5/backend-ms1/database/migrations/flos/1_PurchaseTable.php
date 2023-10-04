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
            $table->decimal('total', 10, 2);
            $table->string('description')->required();

            $table->unsignedBigInteger('purchaseEtat_id');
            $table->foreign('purchaseEtat_id')->references('id')->on('purchase_etat');
            $table->unsignedBigInteger('client_id');
            $table->foreign('client_id')->references('id')->on('client');
            $table->timestamps();
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
