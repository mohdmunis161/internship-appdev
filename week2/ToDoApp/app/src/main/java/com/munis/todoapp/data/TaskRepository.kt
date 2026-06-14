package com.munis.todoapp.data

import androidx.lifecycle.LiveData

class TaskRepository(private val taskDao: TaskDao) {

    suspend fun insert(task: Task) {
        taskDao.insert(task)
    }

    suspend fun update(task: Task) {
        taskDao.update(task)
    }

    suspend fun delete(task: Task) {
        taskDao.delete(task)
    }

    suspend fun clearCompleted() {
        taskDao.clearCompleted()
    }

    fun getAllTasksByCreation(): LiveData<List<Task>> = taskDao.getAllTasksByCreation()
    fun getAllTasksByDueDate(): LiveData<List<Task>> = taskDao.getAllTasksByDueDate()
    fun getActiveTasks(): LiveData<List<Task>> = taskDao.getActiveTasks()
    fun getCompletedTasks(): LiveData<List<Task>> = taskDao.getCompletedTasks()
}
