<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return "Hola desde producción en Kubernetes";
});