import { createRouter, createWebHistory } from "vue-router";
import App from "../App.vue";
import ShopDemo from "../components/ShopDemo.vue";
import DeliveryNote from "../components/DeliveryNote.vue";
import TrackTraceDemo from "../components/TrackTraceDemo.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      redirect: "/shop",
    },
    {
      path: "/shop",
      name: "shop",
      component: ShopDemo,
    },
    {
      path: "/track",
      name: "track",
      component: TrackTraceDemo,
    },
    {
      path: "/delivery",
      name: "delivery",
      component: DeliveryNote,
    },
  ],
});

export default router;
