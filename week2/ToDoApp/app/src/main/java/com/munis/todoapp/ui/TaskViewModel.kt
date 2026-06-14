package com.munis.todoapp.ui

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MediatorLiveData
import androidx.lifecycle.viewModelScope
import com.munis.todoapp.data.Task
import com.munis.todoapp.data.TaskDatabase
import com.munis.todoapp.data.TaskRepository
import kotlinx.coroutines.launch

class TaskViewModel(application: Application) : AndroidViewModel(application) {

    private val repository: TaskRepository
    
    // Sort and Filter state
    var currentFilter = FilterType.ALL
    var currentSort = SortType.CREATION_TIME

    // The data exposed to the UI
    val tasks = MediatorLiveData<List<Task>>()

    private var allTasksByCreation: LiveData<List<Task>>
    private var allTasksByDueDate: LiveData<List<Task>>
    private var activeTasks: LiveData<List<Task>>
    private var completedTasks: LiveData<List<Task>>

    init {
        val taskDao = TaskDatabase.getDatabase(application).taskDao()
        repository = TaskRepository(taskDao)

        allTasksByCreation = repository.getAllTasksByCreation()
        allTasksByDueDate = repository.getAllTasksByDueDate()
        activeTasks = repository.getActiveTasks()
        completedTasks = repository.getCompletedTasks()

        // Setup MediatorLiveData to react to changes from any source based on current filter/sort
        tasks.addSource(allTasksByCreation) { updateList() }
        tasks.addSource(allTasksByDueDate) { updateList() }
        tasks.addSource(activeTasks) { updateList() }
        tasks.addSource(completedTasks) { updateList() }
    }

    private fun updateList() {
        val source = when (currentFilter) {
            FilterType.ALL -> {
                if (currentSort == SortType.DUE_DATE) allTasksByDueDate else allTasksByCreation
            }
            FilterType.ACTIVE -> activeTasks // We'll keep default sort for active/completed for simplicity
            FilterType.COMPLETED -> completedTasks
        }
        tasks.value = source.value
    }

    fun setFilter(filterType: FilterType) {
        currentFilter = filterType
        updateList()
    }

    fun setSort(sortType: SortType) {
        currentSort = sortType
        updateList()
    }

    fun insert(task: Task) = viewModelScope.launch {
        repository.insert(task)
    }

    fun update(task: Task) = viewModelScope.launch {
        repository.update(task)
    }

    fun delete(task: Task) = viewModelScope.launch {
        repository.delete(task)
    }

    fun clearCompleted() = viewModelScope.launch {
        repository.clearCompleted()
    }
}

enum class FilterType {
    ALL, ACTIVE, COMPLETED
}

enum class SortType {
    CREATION_TIME, DUE_DATE
}
