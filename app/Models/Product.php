<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $fillable = [
        'salon_id',
        'name',
        'category',
        'price',
        'stock_quantity',
    ];

    public function salon()
    {
        return $this->belongsTo(Salon::class);
    }
}
