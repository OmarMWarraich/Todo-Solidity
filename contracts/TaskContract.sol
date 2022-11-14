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
}


