//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TaskContract {


    event AddTask(address recipient, uint taskId);
    event DeleteTask(uint taskId, bool isDeleted);

    struct Task {
        uint id;
        string taskText;
        bool isDeleted;
    }

    Task[] private tasks;

    mapping(uint256 => address) taskToOwner;

    function addTask(string memory _taskText, bool isDeleted ) external {
        uint taskId = tasks.length;
        tasks.push(Task(taskId, _taskText, isDeleted));
        taskToOwner[taskId] = msg.sender;
        emit AddTask(msg.sender, taskId);
    }

    function deleteTask(uint _taskId) external {
        require(taskToOwner[_taskId] == msg.sender, "You are not the owner of this task");
        tasks[_taskId].isDeleted = true;
        emit DeleteTask(_taskId, true);
    }

    function getMyTasks() external view returns (Task[] memory){
        Task[] memory temporary = new Task[](tasks.length);
        uint counter = 0;
        for (uint i = 0; i < tasks.length; i++) {
            if (taskToOwner[i] == msg.sender && tasks[i].isDeleted == false) {
                temporary[counter] = tasks[i];
                counter++;
            }
        }
        Task[] memory result = new Task[](counter);
        for (uint i = 0; i < counter; i++) {
            result[i] = temporary[i];
        }
        return result;
    }

}


