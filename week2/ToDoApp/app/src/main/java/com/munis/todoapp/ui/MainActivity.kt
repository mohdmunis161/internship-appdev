package com.munis.todoapp.ui

import android.app.DatePickerDialog
import android.os.Bundle
import android.view.LayoutInflater
import android.widget.Button
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.appbar.MaterialToolbar
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import com.google.android.material.tabs.TabLayout
import com.google.android.material.textfield.TextInputEditText
import com.munis.todoapp.R
import com.munis.todoapp.data.Task
import com.munis.todoapp.databinding.ActivityMainBinding
import java.util.Calendar

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private val viewModel: TaskViewModel by viewModels()
    private lateinit var adapter: TaskAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        androidx.core.view.ViewCompat.setOnApplyWindowInsetsListener(binding.root) { view, windowInsets ->
            val insets = windowInsets.getInsets(androidx.core.view.WindowInsetsCompat.Type.systemBars())
            view.setPadding(0, insets.top, 0, 0)
            androidx.core.view.WindowInsetsCompat.CONSUMED
        }

        setupRecyclerView()
        setupToolbar()
        setupTabs()

        binding.fabAddTask.setOnClickListener {
            showAddEditTaskDialog(null)
        }
    
        viewModel.tasks.observe(this) { tasks ->
            adapter.updateTasks(tasks)
        }
    }

    private fun setupRecyclerView() {
        adapter = TaskAdapter(emptyList(), { task, isChecked ->
            task.isCompleted = isChecked
            viewModel.update(task)
        }, { task ->
            showAddEditTaskDialog(task)
        })

        binding.recyclerView.layoutManager = LinearLayoutManager(this)
        binding.recyclerView.adapter = adapter

        // Swipe to delete
        val itemTouchHelper = ItemTouchHelper(object : ItemTouchHelper.SimpleCallback(0, ItemTouchHelper.LEFT or ItemTouchHelper.RIGHT) {
            override fun onMove(r: RecyclerView, v: RecyclerView.ViewHolder, t: RecyclerView.ViewHolder) = false
            override fun onSwiped(viewHolder: RecyclerView.ViewHolder, direction: Int) {
                val position = viewHolder.adapterPosition
                val taskToDelete = adapter.getTaskAt(position)
                viewModel.delete(taskToDelete)
            }
        })
        itemTouchHelper.attachToRecyclerView(binding.recyclerView)
    }

    private fun setupToolbar() {
        val topAppBar = findViewById<MaterialToolbar>(R.id.topAppBar)
        topAppBar.setOnMenuItemClickListener { menuItem ->
            when (menuItem.itemId) {
                R.id.action_sort_date -> {
                    viewModel.setSort(SortType.DUE_DATE)
                    true
                }
                R.id.action_sort_creation -> {
                    viewModel.setSort(SortType.CREATION_TIME)
                    true
                }
                R.id.action_clear_completed -> {
                    viewModel.clearCompleted()
                    true
                }
                else -> false
            }
        }
    }

    private fun setupTabs() {
        binding.filterTabs.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabSelected(tab: TabLayout.Tab?) {
                when (tab?.position) {
                    0 -> viewModel.setFilter(FilterType.ALL)
                    1 -> viewModel.setFilter(FilterType.ACTIVE)
                    2 -> viewModel.setFilter(FilterType.COMPLETED)
                }
            }
            override fun onTabUnselected(tab: TabLayout.Tab?) {}
            override fun onTabReselected(tab: TabLayout.Tab?) {}
        })
    }

    private fun showAddEditTaskDialog(taskToEdit: Task?) {
        val dialogView = LayoutInflater.from(this).inflate(R.layout.dialog_add_task, null)
        val etTitle = dialogView.findViewById<TextInputEditText>(R.id.etTaskTitle)
        val etDescription = dialogView.findViewById<TextInputEditText>(R.id.etTaskDescription)
        val btnSelectDate = dialogView.findViewById<Button>(R.id.btnSelectDate)

        var selectedDueDate = taskToEdit?.dueDate ?: System.currentTimeMillis()

        if (taskToEdit != null) {
            etTitle.setText(taskToEdit.title)
            etDescription.setText(taskToEdit.description)
            btnSelectDate.text = "Date Selected"
        }

        btnSelectDate.setOnClickListener {
            val calendar = Calendar.getInstance()
            calendar.timeInMillis = selectedDueDate
            DatePickerDialog(this, { _, year, month, dayOfMonth ->
                calendar.set(year, month, dayOfMonth)
                selectedDueDate = calendar.timeInMillis
                btnSelectDate.text = "Date Selected"
            }, calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DAY_OF_MONTH)).show()
        }

        MaterialAlertDialogBuilder(this)
            .setTitle(if (taskToEdit == null) "Add Task" else "Edit Task")
            .setView(dialogView)
            .setPositiveButton("Save") { _, _ ->
                val title = etTitle.text.toString()
                val desc = etDescription.text.toString()
                
                if (title.isNotEmpty()) {
                    if (taskToEdit == null) {
                        val newTask = Task(title = title, description = desc, dueDate = selectedDueDate, creationTime = System.currentTimeMillis())
                        viewModel.insert(newTask)
                    } else {
                        taskToEdit.title = title
                        taskToEdit.description = desc
                        taskToEdit.dueDate = selectedDueDate
                        viewModel.update(taskToEdit)
                    }
                }
            }
            .setNegativeButton("Cancel", null)
            .show()
    }
}
