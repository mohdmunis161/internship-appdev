package com.munis.e_commerceapp.ui

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.munis.e_commerceapp.R
import com.munis.e_commerceapp.model.Product

class ProductAdapter(
    private val products: List<Product>,
    private val onClick: (Product) -> Unit
) : RecyclerView.Adapter<ProductAdapter.ProductViewHolder>() {

    class ProductViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val productImage: ImageView = view.findViewById(R.id.productImage)
        val productName: TextView = view.findViewById(R.id.productName)
        val productPrice: TextView = view.findViewById(R.id.productPrice)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ProductViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_product, parent, false)
        return ProductViewHolder(view)
    }

    override fun onBindViewHolder(holder: ProductViewHolder, position: Int) {
        val product = products[position]
        holder.productName.text = product.name
        holder.productPrice.text = "$" + product.price.toString()

        Glide.with(holder.itemView.context)
            .load(product.imageUrl)
            .centerCrop()
            .into(holder.productImage)

        holder.itemView.setOnClickListener {
            onClick(product)
        }
    }

    override fun getItemCount(): Int {
        return products.size
    }
}
