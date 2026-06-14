package com.munis.e_commerceapp.ui

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.munis.e_commerceapp.R
import com.munis.e_commerceapp.model.CartItem

class CartAdapter(
    private var cartItems: List<CartItem>
) : RecyclerView.Adapter<CartAdapter.CartViewHolder>() {

    class CartViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val cartItemImage: ImageView = view.findViewById(R.id.cartItemImage)
        val cartItemName: TextView = view.findViewById(R.id.cartItemName)
        val cartItemPrice: TextView = view.findViewById(R.id.cartItemPrice)
        val cartItemQuantity: TextView = view.findViewById(R.id.cartItemQuantity)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CartViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_cart, parent, false)
        return CartViewHolder(view)
    }

    override fun onBindViewHolder(holder: CartViewHolder, position: Int) {
        val item = cartItems[position]
        holder.cartItemName.text = item.product.name
        holder.cartItemPrice.text = "$" + item.product.price.toString()
        holder.cartItemQuantity.text = "x" + item.quantity.toString()

        Glide.with(holder.itemView.context)
            .load(item.product.imageUrl)
            .centerCrop()
            .into(holder.cartItemImage)
    }

    override fun getItemCount(): Int {
        return cartItems.size
    }

    fun updateData(newItems: List<CartItem>) {
        cartItems = newItems
        notifyDataSetChanged()
    }
}
