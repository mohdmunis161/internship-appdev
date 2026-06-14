package com.munis.e_commerceapp.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.munis.e_commerceapp.R

class HomeFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_home, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val btnGoToProducts = view.findViewById<Button>(R.id.btnGoToProducts)
        btnGoToProducts.setOnClickListener {
            // Navigate to products tab
            findNavController().navigate(R.id.navigation_products)
        }
    }
}
