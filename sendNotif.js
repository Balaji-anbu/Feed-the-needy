// npm install axios
const axios = require('axios');

const token = 'ya29.c.c0ASRK0GYMr2u0FhsazrOi1CpPFBtN8spFLoLR_Ju_ni-BnmjuSVE8vH7iRzSjmZKdM9kk2AHJVD84M0PbFSpbwb_vD1qgwzOtGlizNMzTmK-k9io0kdtacpS51pHQksBvXsrmt2VN5bqjzAKIbRru9XuP-FEKeZZUmJXakK0HSlnRWgGQAF3EbH9OWOfVGVmU1Xydk9ML-L1tUuFp4V9lwMVWI8RVqrgM9CgPt98-EnHoq_OWBqlK42u8pn4JeZAj4Xk8w0bjmfFtJ53EkroDFDoyGJUXxPXFuuhSkdbtzJp70RpBiE1VbQkT_Sh5WHeuDMRPAVMYU9f8YOG4CrXvqXBv4_FFRvDEO_j21kk4Vx6TLfYVreOKxgE383Cd10msm5buvRMtQBUUXSj19_aXSUlJvbjVYkQkY1alz25zfvk9Xje3kgpiYdfRxfjgs1f20xz8fV-6XxO8MMgXhiVO5tVVb4VlbgF4Bo3k195sMqme6gSJzBIwWdi_Qvb7yuw7Q5WwOsoRhQ90_IqWt_XQWiuhxBicQrJFuQdb1vvM6k_zbFIftOb_tl0OIWRs-yclFhauac5mYog24wU1WX7bJhwRk0JxdJWd1q8p_haIMgOZR3rxkSrWd3Ovwc_hMrvcs8hW3rM8zh50Fh9Q_JXfxm375UO4dyy6neIa7UOh-Jn9IVyZyY4BIeOIq-_eyVZRvJ_nmuVocst8tr3yty2_oogezwnqdZZSp0bsX_9iepqr6uv_Jdl-mkmt-FQwJYiaO97p8ie2n4xnvzy1pW6dcgvjFyuM2-B5XzsbZgRu3Ml_70uochoRxSiBJOczV7ctxgs9kRZeO0z8W4uIJp04W2_8SlazrRzJWS2uSrhbvQbb2rMRgRmpMnpdt9avlIhtnpYkipMXnXUeqXuem8z-90geIFfz56JxxoQ29BrcMit6t1hWoJ8g2kIeIbZvIhwgWdQWBhay_prf6XInw86xF-1RmbhF4p9MS0uYrzI_-rVuQIqpJQ20snW'; // Replace with your generated token

const url = 'https://fcm.googleapis.com/v1/projects/feed-the-needy-8ec15/messages:send';

const messagePayload = {
  message: {
    topic: "all_devices",
    notification: {
      title: "Broadcast Notification",
      body: "This message is sent to all devices!"
    },
    data: {
      type: "chat" // Used for navigation
    },
    android: {
      priority: "high",
      notification: {
        channel_id: "high_importance_channel"
      }
    }
  }
};

const headers = {
  'Authorization': `Bearer ${token}`,
  'Content-Type': 'application/json'
};

axios.post(url, messagePayload, { headers })
  .then(response => {
    console.log('Message sent successfully:', response.data);
  })
  .catch(error => {
    console.error('Error sending message:', error.response ? error.response.data : error.message);
  });