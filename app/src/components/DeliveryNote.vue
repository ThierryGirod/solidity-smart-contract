<template>
  <div>
    <div class="container py-3">
      <div class="text-center">
        <h1>Delivery Note</h1>
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
      <div v-if="this.order">
        <div class="d-flex flex-column">
          <div class="m-2 text-center">
            <div class="card mb-4 rounded-3 shadow-sm">
              <div class="card-header py-3">
                <h4 class="my-0 fw-normal">Order details</h4>
              </div>
              <div class="card-body">
                <table class="table">
                  <tbody>
                    <tr>
                      <th scope="row">State</th>
                      <td>
                        <span
                          class="badge"
                          :class="
                            order[0] == 1
                              ? 'bg-success'
                              : 'bg-warning text-dark'
                          "
                          >{{ order[0] == 1 ? "Payed" : "Open" }}</span
                        >
                      </td>
                    </tr>
                    <tr>
                      <th scope="row">Receiver</th>
                      <td>{{ order[1] }}</td>
                    </tr>
                    <tr>
                      <th scope="row">Product</th>
                      <td>{{ order[2][0] }}</td>
                    </tr>
                    <tr>
                      <th scope="row">Price</th>
                      <td>{{ order[2][1] }} Wei</td>
                    </tr>
                  </tbody>
                </table>
                <div class="d-flex flex-row">
                  <button
                    class="btn btn-success btn-block w-100 m-2"
                    @click="sign()"
                    :hidden="this.order[0] == 1"
                  >
                    &#x2713; Confirm Order
                  </button>
                  <button
                    class="btn btn-danger btn-block w-100 m-2"
                    disabled
                    :hidden="this.order[0] == 1"
                  >
                    &#x2717; Reject Order
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
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
      accounts: [],
    };
  },
  methods: {
    getOrder: function () {
      // method for calling the contract method
      let web3 = new Web3(window.ethereum);
      let contractAddress = "0xF9cA12aEfF1FF9a8f0AB2A3DE74C13a6A10d1D06";
      let abi = JSON.parse(
        `[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"},{"components":[{"internalType":"enum OrderManagement.State","name":"state","type":"uint8"},{"internalType":"address","name":"receiver","type":"address"},{"components":[{"internalType":"string","name":"content","type":"string"},{"internalType":"uint256","name":"price","type":"uint256"}],"internalType":"struct OrderManagement.Product","name":"product","type":"tuple"}],"indexed":false,"internalType":"struct OrderManagement.Order","name":"order","type":"tuple"}],"name":"OrderCreated","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"}],"name":"OrderPayed","type":"event"},{"inputs":[{"internalType":"string","name":"_content","type":"string"},{"internalType":"uint256","name":"_price","type":"uint256"}],"name":"createOrder","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_orderId","type":"uint256"}],"name":"getOrder","outputs":[{"components":[{"internalType":"enum OrderManagement.State","name":"state","type":"uint8"},{"internalType":"address","name":"receiver","type":"address"},{"components":[{"internalType":"string","name":"content","type":"string"},{"internalType":"uint256","name":"price","type":"uint256"}],"internalType":"struct OrderManagement.Product","name":"product","type":"tuple"}],"internalType":"struct OrderManagement.Order","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getOrderCounter","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address payable","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_orderId","type":"uint256"}],"name":"proofDelivery","outputs":[],"stateMutability":"nonpayable","type":"function"}]`
      );
      let contract = new web3.eth.Contract(abi, contractAddress);

      contract.methods
        .getOrder(this.orderId)
        .call()
        .then((result) => (this.order = result));
    },
    sign: function () {
      if (window.ethereum) {
        // first we check if metamask is installed
        window.ethereum
          .request({ method: "eth_requestAccounts" })
          .then((accounts) => {
            this.accounts = accounts;
            let web3 = new Web3(window.ethereum);
            let contractAddress = "0xF9cA12aEfF1FF9a8f0AB2A3DE74C13a6A10d1D06";
            let abi = JSON.parse(
              `[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"},{"components":[{"internalType":"enum OrderManagement.State","name":"state","type":"uint8"},{"internalType":"address","name":"receiver","type":"address"},{"components":[{"internalType":"string","name":"content","type":"string"},{"internalType":"uint256","name":"price","type":"uint256"}],"internalType":"struct OrderManagement.Product","name":"product","type":"tuple"}],"indexed":false,"internalType":"struct OrderManagement.Order","name":"order","type":"tuple"}],"name":"OrderCreated","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"}],"name":"OrderPayed","type":"event"},{"inputs":[{"internalType":"string","name":"_content","type":"string"},{"internalType":"uint256","name":"_price","type":"uint256"}],"name":"createOrder","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_orderId","type":"uint256"}],"name":"getOrder","outputs":[{"components":[{"internalType":"enum OrderManagement.State","name":"state","type":"uint8"},{"internalType":"address","name":"receiver","type":"address"},{"components":[{"internalType":"string","name":"content","type":"string"},{"internalType":"uint256","name":"price","type":"uint256"}],"internalType":"struct OrderManagement.Product","name":"product","type":"tuple"}],"internalType":"struct OrderManagement.Order","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getOrderCounter","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address payable","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_orderId","type":"uint256"}],"name":"proofDelivery","outputs":[],"stateMutability":"nonpayable","type":"function"}]`
            );
            let contract = new web3.eth.Contract(abi, contractAddress);

            let options = {
              filter: {
                value: [],
              },
              fromBlock: "latest",
            };

            contract.events
              .OrderPayed(options)
              .on("data", (event) => {
                let order = [...this.order];
                order[0] = 1;
                this.order = order;
              })
              .on("changed", (changed) => console.log(changed))
              .on("error", (err) => console.error(err));

            contract.methods.proofDelivery(this.orderId).send({
              from: this.accounts[0],
            });
          });
      }
    },
  },
};
</script>
