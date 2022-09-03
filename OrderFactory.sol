// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract OrderFactory {

    struct Order {
        Address sender;
        Address recipient;
        Position[] positions;
        uint price;
    }

    struct Address {
        // Blockchain Address
        string name;
        string street;
        string zip;
        string city;
        string country;
        string addressReference;
    }

    struct Position {
        string content;
    }

    Order[] public orders;

    function createOrder() public {
        // To be implemented
    }

}