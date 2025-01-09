const { GoogleAuth } = require('google-auth-library');
const auth = new GoogleAuth({
    keyFile:'./serviceaccount.json',

    scopes: 'https://www.googleapis.com/auth/firebase.messaging'
});

async function getAccessToken() {
    const Client = await auth.getClient();
    const accessToken = await Client.getAccessToken();
    return accessToken.token;
    
}
getAccessToken().then(token => {
    console.log('Generate OAuth2 token:', token);
}).catch(error => {
console.error('Error generating token:', error);
});
