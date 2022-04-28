require('dotenv').config();
const API_URL = process.env.API_URL;
const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const web3 = createAlchemyWeb3(API_URL);

const contract = require("../artifacts/contracts/NFT.sol/NFT.json");
console.log(JSON.stringify(contract.abi));

const contractAddress = "0xb77Eba46Aae2D9CC2EEf41305866c785e4D763ad";
const nftContract = new web3.eth.Contract(contract.abi, contractAddress);

async function mintNFT(tokenURI) {
    const nonce = await web3.eth.getTransactionCount(PUBLIC_KEY, 'latest'); //get latest nonce
//the transaction
    const tx = {
        'from': PUBLIC_KEY,
        'to': contractAddress,
        'nonce': nonce,
        'gas': 500000,
        'data': nftContract.methods.createNFT(PUBLIC_KEY, tokenURI).encodeABI()
    };
}

const signPromise = web3.eth.accounts.signTransaction(tx, PRIVATE_KEY);
signPromise.then((signedTx) => {
    web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(err, hash) {
        if (!err) {
            console.log("The hash of your transaction is: ", hash);
        } else {
            console.log("Something went wrong when submitting your transaction:", err)
        }
    });
}).catch((err) => {
    console.log(" Promise failed:", err);
});