package com.munis.todoapp.ui

import android.graphics.Paint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.CheckBox
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.munis.todoapp.R
import com.munis.todoapp.data.Task
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

class TaskAdapter(
    private var tasks: List<Task>,
    private val onTaskCheckedChange: (Task, Boolean) -> Unit,
    private val onTaskClick: (Task) -> Unit
) : RecyclerView.Adapter<TaskAdapter.TaskViewHolder>() {

    class TaskViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val cbComplete: CheckBox = view.findViewById(R.id.cbComplete)
        val tvTitle: TextView = view.findViewById(R.id.tvTitle)
        val tvDescription: TextView = view.findViewById(R.id.tvDescription)
        val tvDueDate: TextView = view.findViewById(R.id.tvDueDate)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TaskViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_task, parent, false)
        return TaskViewHolder(view)
    }

    override fun onBindViewHolder(holder: TaskViewHolder, position: Int) {
        val task = tasks[position]
        
        holder.tvTitle.text = task.title
        holder.tvDescription.text = task.description
        
        val sdf = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
        holder.tvDueDate.text = "Due: " + sdf.format(Date(task.dueDate))

        // Remove listener temporarily to avoid trigger during recycling
        holder.cbComplete.setOnCheckedChangeListener(null)
        holder.cbComplete.isChecked = task.isCompleted

        // Strikethrough logic
        if (task.isCompleted) {
            holder.tvTitle.paintFlags = holder.tvTitle.paintFlags or Paint.STRIKE_THRU_TEXT_FLAG
        } else {
            holder.tvTitle.paintFlags = holder.tvTitle.paintFlags and Paint.STRIKE_THRU_TEXT_FLAG.inv()
        }

        holder.cbComplete.setOnCheckedChangeListener { _, isChecked ->
            onTaskCheckedChange(task, isChecked)
        }

        holder.itemView.setOnClickListener {
            onTaskClick(task)
        }
    }

    override fun getItemCount(): Int = tasks.size

    fun updateTasks(newTasks: List<Task>) {
        tasks = newTasks
        notifyDataSetChanged()
    }
    
    fun getTaskAt(position: Int): Task {
        return tasks[position]
    }
}
