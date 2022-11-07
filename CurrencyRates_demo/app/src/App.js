import {useState,useEffect} from 'react';
import PriceConsumerV3 from "./artifacts/contracts/PriceConsumerV3.sol/PriceConsumerV3.json";
import {ethers} from "ethers";
import './App.css';
//const {Network,Alchemy}=require("alchemy-sdk");
//const {createAlchemyWeb3} =require ("@alch/alchemy-web3");
//const settings = {
 // apiKey: "moh2vvLvVu6uBaELa2GLxwCkGjXdfHb0",
 // network: Network.ETH_GOERLI,
//};
 
//const alchemy = new Alchemy(settings); 
//const url="https://eth-goerli.g.alchemy.com/v2/moh2vvLvVu6uBaELa2GLxwCkGjXdfHb0";
  //const web3=createAlchemyWeb3(url);


  
function App() {

  const [latestPrice, setLatestPrice] = useState(0);
  const [contract, setContract] = useState(null);
  const [provider, setProvider] = useState(null);

  useEffect(() => {
    const loadProvider = async () => {
      let contractAddress = "0xa2874a3d0bc54643d9ecbe496ebd4bd1da2a87aa";
      const API_KEY = "moh2vvLvVu6uBaELa2GLxwCkGjXdfHb0";

      const provider = new ethers.providers.AlchemyProvider("goerli", API_KEY);
      const contract = new ethers.Contract(
        contractAddress,
        PriceConsumerV3.abi,
        provider
      );
      setContract(contract);
      setProvider(provider);
      //console.log(contract);
    };
    loadProvider();
  }, []);

  useEffect(()=>{ 
    const getPrice = async()=>{
      const price= await contract.getLatestPriceETHUSD();
       const x = 1/1000000000000000000;
      const y=price.toNumber();
      const rate =(x * y).toFixed(4);
      setLatestPrice(rate);
    };

    contract && getPrice();
  },[contract]);

  const getJPYUSD = async () => {
    // const signer = contract.connect(provider.getSigner());
    const price= await contract.getLatestPriceJPYUSD();
     const x = 1/1000000000000000000;
     const y=price.toNumber();
     const rate =(x * y).toFixed(4);
     setLatestPrice(rate);
     
    };

    const getETHUSD = async () => {
      // const signer = contract.connect(provider.getSigner());
      const pricee= await contract.getLatestPriceETHUSD();
       console.log("eth price"+ pricee.toNumber);
       const x = 1/100000000;
       const y=pricee.toNumber();
       const rate =(x * y).toFixed(4);
       setLatestPrice(rate);
      
      };
 
  return (
    <div className="center">
      <h4>latest rate:{latestPrice}</h4>
      <button className="button" onClick={getJPYUSD}>
      JPY/USD
      </button>
      <button className="button" onClick={getETHUSD}>
      ETH/USD
      </button>
    </div>
  );
}

export default App;
