const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// Notify donor when needer requests food
exports.notifyDonorOnRequest = functions.firestore
  .document("food_requests/{requestId}")
  .onCreate(async (snap, context) => {
    const requestData = snap.data();
    const donorId = requestData.donorId;

    const donorDoc = await admin.firestore().collection("users").doc(donorId).get();
    const donorToken = donorDoc.data()?.fcmToken;

    if (!donorToken) {
      console.error("Donor FCM token not found.");
      return;
    }

    const message = {
      token: donorToken,
      notification: {
        title: "New Food Request",
        body: "A needer has requested food. Check your app to respond.",
      },
      data: {
        requestId: context.params.requestId,
      },
    };

    try {
      await admin.messaging().send(message);
      console.log("Notification sent to donor.");
    } catch (error) {
      console.error("Error sending notification to donor:", error);
    }
  });

// Notify needer when donor accepts request
exports.notifyNeederOnAcceptance = functions.firestore
  .document("food_requests/{requestId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    if (before.status === "requested" && after.status === "accepted") {
      const neederId = after.neederId;

      const neederDoc = await admin.firestore().collection("users").doc(neederId).get();
      const neederToken = neederDoc.data()?.fcmToken;

      if (!neederToken) {
        console.error("Needer FCM token not found.");
        return;
      }

      const message = {
        token: neederToken,
        notification: {
          title: "Request Accepted",
          body: "Your food request has been accepted by the donor. Check your app for details.",
        },
        data: {
          requestId: context.params.requestId,
        },
      };

      try {
        await admin.messaging().send(message);
        console.log("Notification sent to needer.");
      } catch (error) {
        console.error("Error sending notification to needer:", error);
      }
    }
  });
