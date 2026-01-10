importScripts("https://www.gstatic.com/firebasejs/9.0.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyCk3VygYBELbSptHa0IZ-3SOVR5tsR4v-I",
  projectId: "nusa-f38ea",
  messagingSenderId: "276499509152",
  appId: "1:276499509152:web:ed8a8e614e5f9219e43ec5",
});

const messaging = firebase.messaging();

// Opsional: Menangani pesan saat di background
messaging.onBackgroundMessage((payload) => {
  console.log("Pesan Background diterima: ", payload);
});