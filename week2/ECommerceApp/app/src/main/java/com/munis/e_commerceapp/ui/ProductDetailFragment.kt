package com.munis.e_commerceapp.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import com.bumptech.glide.Glide
import com.munis.e_commerceapp.R
import com.munis.e_commerceapp.viewmodel.CartViewModel

class ProductDetailFragment : Fragment() {

    private val sharedViewModel: CartViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_product_detail, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val productId = arguments?.getInt("productId") ?: return
        val product = sharedViewModel.allProducts.find { it.id == productId }

        if (product != null) {
            val detailImage = view.findViewById<ImageView>(R.id.detailImage)
            val detailName = view.findViewById<TextView>(R.id.detailName)
            val detailPrice = view.findViewById<TextView>(R.id.detailPrice)
            val detailDescription = view.findViewById<TextView>(R.id.detailDescription)
            val btnAddToCart = view.findViewById<Button>(R.id.btnAddToCart)

            Glide.with(this)
                .load(product.imageUrl)
                .centerCrop()
                .into(detailImage)

            detailName.text = product.name
            detailPrice.text = "$" + product.price.toString()
            detailDescription.text = product.description

            btnAddToCart.setOnClickListener {
                sharedViewModel.addToCart(product)
                Toast.makeText(requireContext(), "Added to Cart!", Toast.LENGTH_SHORT).show()
            }
        }
    }
}
