package com.munis.e_commerceapp

import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.setupWithNavController
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.munis.e_commerceapp.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val navHostFragment = supportFragmentManager
            .findFragmentById(R.id.nav_host_fragment) as NavHostFragment
        val navController = navHostFragment.navController
        val bottomNav = findViewById<BottomNavigationView>(R.id.bottom_nav)

        bottomNav.setupWithNavController(navController)

        // Hide bottom nav on splash and product detail screens
        navController.addOnDestinationChangedListener { _, destination, _ ->
            if (destination.id == R.id.navigation_splash || destination.id == R.id.navigation_product_detail) {
                bottomNav.visibility = View.GONE
            } else {
                bottomNav.visibility = View.VISIBLE
            }
        }
    }
}