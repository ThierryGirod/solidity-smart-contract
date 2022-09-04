// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract OrderManagement {

    // Custom event that is triggered when a new order is created
    event OrderCreated(uint id, Order order);

    // Custom object structure for order details
    struct Order {
        address receiver;
        string content;
        uint price;
    }

    // Payable address can receive Ether.
    // Is the address of the seller of the products.
    address payable public owner;

    // Orders counter to create id from
    uint orderCounter;

    // Mapping that holds all the orders
    mapping(uint => Order) orders;

    constructor() {
        owner = payable(msg.sender);
    }

    // Function to get a new unique id
    function _getUniqueId() private returns (uint) {
        orderCounter += 1;
        return uint(keccak256(abi.encodePacked(orderCounter)));
    }

    // Function to crate a new order with the amount of ether it requires
    function createOrder(string memory _content, uint _price) external payable {
        uint id = _getUniqueId();
        Order memory order = Order(msg.sender, _content, _price);
        orders[id] = order;
        emit OrderCreated(id, order);
    }

    // View order counter
    function getOrderCounter() external view returns(uint) {
        return orderCounter;
    }

}