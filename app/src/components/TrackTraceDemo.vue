<template>
  <div>
    <div class="container py-3">
      <div class="text-center">
        <h1>Track Trace</h1>
      </div>

      <div>
        <div class="form-group mb-2">
          <input
            type="text"
            class="form-control"
            v-model="this.orderId"
            placeholder="Order Number"
          />
        </div>

        <button
          type="button"
          class="btn btn-primary btn-block w-100"
          @click="getOrder()"
        >
          Search
        </button>
      </div>
      <div>
        {{ order }}
      </div>
    </div>
  </div>
</template>

<script>
import Web3 from "web3";
export default {
  data() {
    return {
      orderId: null,
      order: null,
    };
  },
  methods: {
    getOrder: function () {
      // method for calling the contract method
      let web3 = new Web3(window.ethereum);
      let contractAddress = "0x594365657B492991280086c271863EB5a9428262";
      let abi = JSON.parse(
        `[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"},{"components":[{"internalType":"enum OrderManagement.State","name":"state","type":"uint8"},{"internalType":"address","name":"receiver","type":"address"},{"components":[{"internalType":"string","name":"content","type":"string"},{"internalType":"uint256","name":"price","type":"uint256"}],"internalType":"struct OrderManagement.Product","name":"product","type":"tuple"}],"indexed":false,"internalType":"struct OrderManagement.Order","name":"order","type":"tuple"}],"name":"OrderCreated","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"}],"name":"OrderPayed","type":"event"},{"inputs":[{"internalType":"string","name":"_content","type":"string"},{"internalType":"uint256","name":"_price","type":"uint256"}],"name":"createOrder","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_orderId","type":"uint256"}],"name":"getOrder","outputs":[{"components":[{"internalType":"enum OrderManagement.State","name":"state","type":"uint8"},{"internalType":"address","name":"receiver","type":"address"},{"components":[{"internalType":"string","name":"content","type":"string"},{"internalType":"uint256","name":"price","type":"uint256"}],"internalType":"struct OrderManagement.Product","name":"product","type":"tuple"}],"internalType":"struct OrderManagement.Order","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getOrderCounter","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address payable","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_orderId","type":"uint256"}],"name":"proofDelivery","outputs":[],"stateMutability":"nonpayable","type":"function"}]`
      );
      let contract = new web3.eth.Contract(abi, contractAddress);

      contract.methods
        .getOrder(this.orderId)
        .call()
        .then((result) => console.log(result));
      this.order = this.orderId;
    },
  },
};
</script>
