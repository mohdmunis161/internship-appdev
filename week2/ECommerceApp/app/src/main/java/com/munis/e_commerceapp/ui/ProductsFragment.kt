package com.munis.e_commerceapp.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.munis.e_commerceapp.R
import com.munis.e_commerceapp.viewmodel.CartViewModel

class ProductsFragment : Fragment() {

    private val sharedViewModel: CartViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_products, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val recyclerView = view.findViewById<RecyclerView>(R.id.productsRecyclerView)
        recyclerView.layoutManager = GridLayoutManager(requireContext(), 2)

        val adapter = ProductAdapter(sharedViewModel.allProducts) { product ->
            // Click on product, go to details
            val bundle = Bundle()
            bundle.putInt("productId", product.id)
            findNavController().navigate(R.id.action_products_to_detail, bundle)
        }

        recyclerView.adapter = adapter
    }
}
