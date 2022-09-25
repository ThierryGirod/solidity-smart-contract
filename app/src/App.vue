<script>
import Web3 from "web3";
export default {
  name: "App",
};
</script>

<template>
  <div>
    <div class="container">
      <header class="d-flex justify-content-center py-3">
        <ul class="nav nav-pills">
          <li class="nav-item">
            <router-link to="/shop" class="nav-link">Shop Demo</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/delivery" class="nav-link"
              >Delivery Note</router-link
            >
          </li>
        </ul>
      </header>
    </div>
    <router-view></router-view>
  </div>
</template>
