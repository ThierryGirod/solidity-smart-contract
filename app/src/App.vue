<script>
export default {
  data() {
    return {
      isMetaMask: ethereum.isMetaMask,
      isConnected: ethereum.isConnected(),
      chainId: null,
    };
  },
  mounted() {
    ethereum
      .request({ method: "eth_chainId" })
      .then((result) => (this.chainId = result));
    console.log(`the component is now mounted`);
  },
};
</script>

<template>
  <div>
    <div>
      <button class="bg-primary">test</button>
    </div>
    <div>
      <table class="table-auto">
        <thead>
          <tr>
            <th>Property</th>
            <th>Value</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>isMetaMask</td>
            <td>{{ isMetaMask }}</td>
          </tr>
          <tr>
            <td>isConnected</td>
            <td>{{ isConnected }}</td>
          </tr>
          <tr>
            <td>chainId</td>
            <td>{{ chainId }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
