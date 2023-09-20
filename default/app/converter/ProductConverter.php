<?php

namespace App\Converter;

use App\Dto\ProductDto;
use App\Models\Product;

class ProductConverter
{
    public function toItem(ProductDto $dto)
    {
        $item = new Product();
        $item->setReference($dto->getReference());
        $item->setLabel($dto->getLabel());
        return $item;
    }

    public function toDto(Product $item)
    {
        $dto = new ProductDto();
        $dto->setReference($item->getReference());
        $dto->setLabel($item->getLabel());
        return $dto;
    }
}
