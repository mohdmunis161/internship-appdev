package com.munis.e_commerceapp.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.munis.e_commerceapp.model.CartItem
import com.munis.e_commerceapp.model.Product

class CartViewModel : ViewModel() {

    // Simple list of products with real images
    val allProducts = listOf(
        Product(1, "Laptop Pro", "High performance laptop with 16GB RAM, 512GB SSD and a stunning retina display for professionals.", 1299.99, "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400"),
        Product(2, "Wireless Mouse", "Ergonomic wireless mouse with silent clicks and long battery life. Works on any surface.", 49.99, "https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=400"),
        Product(3, "Mechanical Keyboard", "RGB backlit mechanical keyboard with cherry switches. Built for gaming and typing.", 89.99, "https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400"),
        Product(4, "HD Monitor", "27 inch 4K ultra HD monitor with IPS panel. Perfect for design work and entertainment.", 199.99, "https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=400"),
        Product(5, "Headphones", "Noise cancelling over-ear headphones with deep bass. Up to 30 hours battery life.", 149.99, "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400"),
        Product(6, "USB-C Hub", "7 in 1 USB-C hub with HDMI, USB 3.0, SD card reader and ethernet port.", 39.99, "https://images.unsplash.com/photo-1625842268584-8f3296236761?w=400")
    )

    private val _cartItems = MutableLiveData<List<CartItem>>(emptyList())
    val cartItems: LiveData<List<CartItem>> = _cartItems

    fun addToCart(product: Product) {
        val currentList = _cartItems.value?.toMutableList() ?: mutableListOf()
        val existingItem = currentList.find { it.product.id == product.id }
        
        if (existingItem != null) {
            existingItem.quantity += 1
        } else {
            currentList.add(CartItem(product, 1))
        }
        _cartItems.value = currentList
    }

    fun getTotalPrice(): Double {
        var total = 0.0
        val items = _cartItems.value
        if (items != null) {
            for (item in items) {
                total += item.product.price * item.quantity
            }
        }
        return total
    }
}
