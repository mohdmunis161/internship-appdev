package com.munis.e_commerceapp.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.munis.e_commerceapp.R
import com.munis.e_commerceapp.viewmodel.CartViewModel

class CartFragment : Fragment() {

    private val sharedViewModel: CartViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_cart, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val recyclerView = view.findViewById<RecyclerView>(R.id.cartRecyclerView)
        recyclerView.layoutManager = LinearLayoutManager(requireContext())

        val cartTotal = view.findViewById<TextView>(R.id.cartTotal)
        val btnCheckout = view.findViewById<Button>(R.id.btnCheckout)

        val adapter = CartAdapter(emptyList())
        recyclerView.adapter = adapter

        // Observe cart items
        sharedViewModel.cartItems.observe(viewLifecycleOwner) { items ->
            adapter.updateData(items)
            val total = sharedViewModel.getTotalPrice()
            cartTotal.text = "$" + "%.2f".format(total)
        }

        btnCheckout.setOnClickListener {
            if (sharedViewModel.getTotalPrice() > 0) {
                Toast.makeText(requireContext(), "Checking out...", Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(requireContext(), "Cart is empty", Toast.LENGTH_SHORT).show()
            }
        }
    }
}
