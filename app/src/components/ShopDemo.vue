<template>
  <div>
    <div class="container py-3">
      <main>
        <div
          class="row row-cols-1 row-cols-md-3 mb-3 text-center"
          v-if="!connected"
        >
          <button class="btn btn-primary" @click="connect">
            Connect Wallet
          </button>
        </div>
        <div class="d-flex flex-column mb-3" v-if="connected">
          <div>
            <div
              class="alert alert-primary m-2"
              role="alert"
              v-if="orderId !== null"
            >
              Your order is saved with id: {{ this.orderId }}
            </div>
            <div class="d-flex flex-column flex-lg-row">
              <div v-for="product in products" class="m-2 text-center">
                <div class="card mb-4 rounded-3 shadow-sm">
                  <div class="card-header py-3">
                    <h4 class="my-0 fw-normal">{{ product.name }}</h4>
                  </div>
                  <div class="card-body">
                    <img
                      :src="product.image"
                      class="img-fluid mb-5"
                      style="height: 200px"
                    />
                    <button
                      type="button"
                      class="w-100 btn btn-lg btn-primary"
                      @click="buy(product.id)"
                    >
                      Buy for {{ product.price }} &#208;
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  </div>
</template>

<script>
import Web3 from "web3";
import BigNumber from "bignumber.js";
export default {
  name: "ShopDemo",

  data() {
    return {
      products: [
        {
          id: "1",
          name: "Apple MacBook Pro – 2022",
          image: "/macbook-pro.avif",
          price: "0.5",
        },
        {
          id: "2",
          name: "Apple iPad 2021 – 9. Gen",
          image: "/ipad-pro-12.jpeg",
          price: "0.09",
        },
        {
          id: "3",
          name: "iPhone 14 Plus",
          image: "/iphone-14.avif",
          price: "0.075",
        },
      ],
      connected: false,
      contractResult: "",
      accounts: [],
      orderId: null,
    };
  },
  methods: {
    connect: function () {
      // this connects to the wallet

      if (window.ethereum) {
        // first we check if metamask is installed
        window.ethereum
          .request({ method: "eth_requestAccounts" })
          .then((accounts) => {
            this.accounts = accounts;
            this.connected = true; // If users successfully connected their wallet
          });
      }
    },
    buy: function (id) {
      // method for calling the contract method
      let web3 = new Web3(window.ethereum);
      let contractAddress = "0x594365657B492991280086c271863EB5a9428262";
      let abi = JSON.parse(
        `[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"},{"components":[{"internalType":"enum OrderManagement.State","name":"state","type":"uint8"},{"internalType":"address","name":"receiver","type":"address"},{"components":[{"internalType":"string","name":"content","type":"string"},{"internalType":"uint256","name":"price","type":"uint256"}],"internalType":"struct OrderManagement.Product","name":"product","type":"tuple"}],"indexed":false,"internalType":"struct OrderManagement.Order","name":"order","type":"tuple"}],"name":"OrderCreated","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"}],"name":"OrderPayed","type":"event"},{"inputs":[{"internalType":"string","name":"_content","type":"string"},{"internalType":"uint256","name":"_price","type":"uint256"}],"name":"createOrder","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_orderId","type":"uint256"}],"name":"getOrder","outputs":[{"components":[{"internalType":"enum OrderManagement.State","name":"state","type":"uint8"},{"internalType":"address","name":"receiver","type":"address"},{"components":[{"internalType":"string","name":"content","type":"string"},{"internalType":"uint256","name":"price","type":"uint256"}],"internalType":"struct OrderManagement.Product","name":"product","type":"tuple"}],"internalType":"struct OrderManagement.Order","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getOrderCounter","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address payable","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_orderId","type":"uint256"}],"name":"proofDelivery","outputs":[],"stateMutability":"nonpayable","type":"function"}]`
      );
      let contract = new web3.eth.Contract(abi, contractAddress);

      let product = this.products.find((p) => p.id == id);

      let options = {
        filter: {
          value: [],
        },
        fromBlock: "latest",
      };

      contract.events
        .OrderCreated(options)
        .on("data", (event) => (this.orderId = event.returnValues.id))
        .on("changed", (changed) => console.log(changed))
        .on("error", (err) => console.error(err));

      contract.methods
        .createOrder(product.name, web3.utils.toWei(product.price, "ether"))
        .send({
          from: this.accounts[0],
          value: web3.utils.toWei(product.price, "ether"),
        });
    },
  },
};
</script>
