// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract OrderManagement {

    // Custom event that is triggered when a new order is created
    event OrderCreated(uint id, Order order);

    // Custom event that is triggered when an order is payed
    event OrderPayed(uint id);

    // Custom order states
    enum State {
        OPEN,
        PAYED
    }

    // Custom object structure for order details
    struct Order {
        State state;
        address receiver;
        Product product;
    }

    // Custom object structure for product details
    struct Product {
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
        require(msg.sender != owner && msg.value == _price);
        uint id = _getUniqueId();
        Order memory order = Order(State.OPEN, msg.sender, Product(_content, _price));
        orders[id] = order;
        emit OrderCreated(id, order);
    }

    // View order counter
    function getOrderCounter() external view returns(uint) {
        require(msg.sender == owner);
        return orderCounter;
    }
    
    // View an order
    function getOrder(uint _orderId) external view returns (Order memory) {
        Order memory order = orders[_orderId];
        return order;
    }

    // Function that when the proof of delivery is signed by the receiver pays the open amount
    function proofDelivery(uint _orderId) external {
        Order memory order = orders[_orderId];
        require(msg.sender == order.receiver);

        // Pay the amount
        (bool success, ) = owner.call{value: order.product.price}("");
        require(success, "Failed to send Ether");

        // Update the state of the order
        order.state = State.PAYED;
        orders[_orderId] = order;
        emit OrderPayed(_orderId);
    }

}