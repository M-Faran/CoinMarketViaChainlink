const contractAddress = "0x3AA4762196f833dF96AbD5eb52eA04aCf2d5082F";
const abi = [
    {
        "type": "constructor",
        "inputs": [],
        "stateMutability": "nonpayable"
    },
    {
        "type": "function",
        "name": "getLatestPrice",
        "inputs": [
            {
                "name": "_asset",
                "type": "string",
                "internalType": "string"
            }
        ],
        "outputs": [
            {
                "name": "",
                "type": "int256",
                "internalType": "int256"
            }
        ],
        "stateMutability": "view"
    },
    {
        "type": "function",
        "name": "getPriceFeed",
        "inputs": [
            {
                "name": "_asset",
                "type": "string",
                "internalType": "string"
            }
        ],
        "outputs": [
            {
                "name": "",
                "type": "address",
                "internalType": "address"
            }
        ],
        "stateMutability": "view"
    }
];

async function fetchPrice(asset) {
    if (!window.ethereum) {
        alert("MetaMask is not detected! Please install MetaMask.");
        return;
    }

    try {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        await provider.send("eth_requestAccounts", []);
        const signer = provider.getSigner();
        const contract = new ethers.Contract(contractAddress, abi, signer);
        const price = await contract.getLatestPrice(`${asset}/USD`);
        const priceInDollars = (Number(price) / 1e8).toFixed(2);

        document.getElementById(`${asset.toLowerCase()}-price`).innerText = `$${priceInDollars}`;
    } catch (error) {
        console.error(error);
        alert("Error fetching price. Check console for details.");
    }
}
