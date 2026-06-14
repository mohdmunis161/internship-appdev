package com.munis.todoapp.data

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Update

@Dao
interface TaskDao {
    @Insert
    suspend fun insert(task: Task)

    @Update
    suspend fun update(task: Task)

    @Delete
    suspend fun delete(task: Task)

    @Query("DELETE FROM task_table WHERE isCompleted = 1")
    suspend fun clearCompleted()

    // Queries returning LiveData for the UI
    @Query("SELECT * FROM task_table ORDER BY creationTime DESC")
    fun getAllTasksByCreation(): LiveData<List<Task>>

    @Query("SELECT * FROM task_table ORDER BY dueDate ASC")
    fun getAllTasksByDueDate(): LiveData<List<Task>>

    @Query("SELECT * FROM task_table WHERE isCompleted = 0 ORDER BY creationTime DESC")
    fun getActiveTasks(): LiveData<List<Task>>

    @Query("SELECT * FROM task_table WHERE isCompleted = 1 ORDER BY creationTime DESC")
    fun getCompletedTasks(): LiveData<List<Task>>
}
